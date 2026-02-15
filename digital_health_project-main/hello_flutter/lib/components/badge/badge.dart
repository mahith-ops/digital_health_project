import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String? label;
  final Color? color;
  final Color? textColor;
  final BadgePosition position;

  const Badge({
    super.key,
    required this.child,
    this.label,
    this.color,
    this.textColor,
    this.position = BadgePosition.topRight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (label != null)
          Positioned(
            right: position == BadgePosition.topRight ? -8 : null,
            left: position == BadgePosition.topLeft ? -8 : null,
            top: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color ?? Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                label!,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

enum BadgePosition {
  topRight,
  topLeft,
}





