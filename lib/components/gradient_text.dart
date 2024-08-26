import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final EdgeInsets padding;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
    this.padding = const EdgeInsets.symmetric(horizontal: 3.0),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: style.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
