import 'dart:core';
import 'package:flutter/material.dart' as material;

class Tooltip extends material.StatelessWidget {
  final material.Widget child;
  final String message;
  final Duration? waitDuration;
  final TooltipPosition position;

  const Tooltip({
    super.key,
    required this.child,
    required this.message,
    this.waitDuration,
    this.position = TooltipPosition.bottom,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Tooltip(
      message: message,
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
      preferBelow: position == TooltipPosition.bottom,
      verticalOffset: _getVerticalOffset(),
      child: child,
    );
  }

  double _getVerticalOffset() {
    switch (position) {
      case TooltipPosition.top:
        return -10;
      case TooltipPosition.bottom:
        return 10;
      case TooltipPosition.left:
      case TooltipPosition.right:
        return 0;
    }
  }
}

enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

