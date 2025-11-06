import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final List<Color> gradientColors;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.gradientColors = const [Color(0xFF7B61FF), Color(0xFF9A7AFF)],
    this.height = 54,
    this.borderRadius = 18,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? Colors.white;

    final isClickable = !isLoading;

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Platform.isIOS
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                onPressed: isClickable ? onPressed : null,
                child: _buildChild(effectiveTextColor),
              ),
            )
          : ElevatedButton(
              onPressed: isClickable ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: EdgeInsets.zero,
              ),
              child: _buildChild(effectiveTextColor),
            ),
    );
  }

  Widget _buildChild(Color textColor) {
    return isLoading
        ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
        : Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              letterSpacing: 0.5,
            ),
          );
  }
}
