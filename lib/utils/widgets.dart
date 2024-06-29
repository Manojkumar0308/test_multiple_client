import 'package:flutter/material.dart';

class CustomWidgetContainer extends StatelessWidget {
  final double height;
  final double width;
  final Gradient gradient;
  final Widget child;

  CustomWidgetContainer({
    required this.height,
    required this.width,
    required this.gradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10)
      ),
      child: child,
    );
  }
}
