import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const Divider({
    super.key,
    this.height,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height ?? 1,
        margin: EdgeInsets.only(
          left: indent ?? 0,
          right: endIndent ?? 0,
        ),
        decoration: BoxDecoration(
          color: color ?? Colors.grey[300],
        ),
      ),
    );
  }
}





