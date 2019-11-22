import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final double height;
  final Color color;

  const HorizontalDivider({
    this.height = 0.5,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
    );
  }
}
