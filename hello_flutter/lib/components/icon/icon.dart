import 'package:flutter/material.dart' as material;

class Icon extends material.StatelessWidget {
  final material.IconData iconData;
  final double? size;
  final material.Color? color;

  const Icon({
    super.key,
    required this.iconData,
    this.size,
    this.color,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Material(
      color: material.Colors.transparent,
      child: material.Icon(
        iconData,
        size: size ?? 24,
        color: color ?? material.Theme.of(context).iconTheme.color,
      ),
    );
  }
}

