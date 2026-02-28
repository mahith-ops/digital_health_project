import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  final Widget child;
  final Widget content;
  final PopoverPosition position;
  final double? width;

  const Popover({
    super.key,
    required this.child,
    required this.content,
    this.position = PopoverPosition.bottom,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: _getOffset(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Container(
            width: width ?? 200,
            padding: const EdgeInsets.all(8),
            child: content,
          ),
        ),
      ],
      child: child,
    );
  }

  Offset _getOffset() {
    switch (position) {
      case PopoverPosition.top:
        return const Offset(0, -10);
      case PopoverPosition.bottom:
        return const Offset(0, 10);
      case PopoverPosition.left:
        return const Offset(-10, 0);
      case PopoverPosition.right:
        return const Offset(10, 0);
    }
  }
}

enum PopoverPosition { top, bottom, left, right }
