import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool enableBlur;
  final bool enableShadow;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.showBackButton = false,
    this.actions,
    this.enableBlur = false,
    this.enableShadow = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bgColor =
        backgroundColor ??
        (theme.brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white);

    return Container(
      decoration: BoxDecoration(
        color: enableBlur ? bgColor.withOpacity(0.85) : bgColor,
        boxShadow: enableShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: SafeArea(
        bottom: false,
        child: ClipRRect(
          child: enableBlur
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: _buildContent(context, theme),
                )
              : _buildContent(context, theme),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back or Placeholder
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: theme.iconTheme.color,
              onPressed: () => Get.back(),
            )
          else
            const SizedBox(width: 48),

          // Title
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

          // Actions
          if (actions != null && actions!.isNotEmpty)
            Row(children: actions!)
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
