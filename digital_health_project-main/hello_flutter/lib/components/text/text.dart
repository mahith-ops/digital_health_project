import 'package:flutter/material.dart' as material;

class Text extends material.StatelessWidget {
  final String data;
  final material.TextStyle? style;
  final material.TextAlign? textAlign;
  final material.TextOverflow? overflow;
  final int? maxLines;

  const Text(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Material(
      color: material.Colors.transparent,
      child: material.Text(
        data,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}

