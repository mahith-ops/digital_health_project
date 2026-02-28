import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? label;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;

  const TextArea({
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: value != null ? TextEditingController(text: value) : null,
          onChanged: onChanged,
          maxLines: maxLines ?? 5,
          minLines: minLines ?? 3,
          maxLength: maxLength,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}





