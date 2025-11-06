import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;

  const SvgIcon(this.path, {super.key, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          height: size,
          width: size,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ));
  }
}
