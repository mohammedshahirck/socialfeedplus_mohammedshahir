import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialfeedplus_mohammedshahir/core/utils/rount_toK.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/svg_icon.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
    required this.likeCount,
    this.iconSize,
    this.textStyle,
    this.activeIcon,
    this.icon = 'assets/images/ic_heart.svg',

    this.childSpacing,
    this.animate = true,
    this.activeColor,
    this.inactiveColor,
    this.iconsScale = 1,
    this.showCount = true,
    this.canToggle = true,
  });
  final RxBool isLiked;
  final RxInt likeCount;
  final Function(bool liked) onPressed;
  final double? iconSize;
  final TextStyle? textStyle;
  final String icon;
  final String? activeIcon;
  final bool animate;

  final double? childSpacing;
  final Color? activeColor;
  final Color? inactiveColor;
  final double iconsScale;
  final bool showCount;
  final bool canToggle;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller =
          AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: this,
          )..addStatusListener((status) {
            if (status == AnimationStatus.completed) _controller.reset();
          });
      scaleAnimation = Tween(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: const OvershootCurve()),
      );
    }
  }

  @override
  void dispose() {
    if (widget.animate) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPress,
      behavior: HitTestBehavior.opaque,
      child: Obx(
        () => widget.showCount
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: widget.iconsScale,
                    child: widget.animate ? getAnimator() : getIcon(),
                  ),
                  const SizedBox(width: 6),
                  getText(),
                ],
              )
            : Transform.scale(
                scale: widget.iconsScale,
                child: widget.animate ? getAnimator() : getIcon(),
              ),
      ),
    );
  }

  void _onPress() {
    widget.onPressed(widget.isLiked.value);
    if (!widget.canToggle) return;
    widget.isLiked.toggle();
    if (widget.isLiked.value) {
      widget.likeCount.value++;
    } else {
      widget.likeCount.value--;
    }
    if (widget.animate) {
      _controller.reset();
      _controller.forward();
    }
  }

  Widget getIcon() {
    return SvgIcon(
      _getIconPath(),
      size: widget.iconSize ?? 24,
      color: widget.isLiked.value
          ? widget.activeColor ?? Colors.red
          : widget.inactiveColor,
    );
  }

  String _getIconPath() =>
      widget.isLiked.value ? widget.activeIcon ?? widget.icon : widget.icon;
  Widget getText() {
    return Text(
      widget.likeCount.value == 0 ? "Like" : widget.likeCount.value.roundToK(),
      style: widget.textStyle,
    );
  }

  Widget getAnimator() {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _controller.isAnimating ? scaleAnimation.value : 1,
          child: child,
        );
      },
      child: getIcon(),
    );
  }
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.period = 4]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }
}
