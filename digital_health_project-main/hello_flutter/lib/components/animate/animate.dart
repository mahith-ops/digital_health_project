import 'package:flutter/material.dart';

class Animate extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const Animate({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      child: child,
    );
  }
}





