import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final double borderWidth;
  final Widget child;

  const GradientBorderContainer({
    super.key,
    required this.borderWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF16B6A), // Red
            Color(0xFFFFAA5D), // Orange
            Color(0xFF6E38E1), // Purple
          ],
          stops: [0.05, 0.5, 0.9997],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: child,
        ),
      ),
    );
  }
}
