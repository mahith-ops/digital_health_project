import 'package:flutter/material.dart' as material;

class TextField extends material.StatelessWidget {
  final String? value;
  final material.ValueChanged<String>? onChanged;
  final material.ValueChanged<String>? onSubmitted;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final material.TextInputType? keyboardType;
  final material.Widget? prefixIcon;
  final material.Widget? suffixIcon;
  final bool enabled;
  final int? maxLength;

  const TextField({
    super.key,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLength,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.Column(
      crossAxisAlignment: material.CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          material.Text(
            label!,
            style: const material.TextStyle(fontSize: 14, fontWeight: material.FontWeight.w500),
          ),
          const material.SizedBox(height: 8),
        ],
        material.TextField(
          controller: value != null ? material.TextEditingController(text: value) : null,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLength: maxLength,
          decoration: material.InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
            border: const material.OutlineInputBorder(),
            contentPadding: const material.EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}

