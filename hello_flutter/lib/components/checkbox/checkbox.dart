import 'package:flutter/material.dart';

class Checkbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Color? activeColor;

  const Checkbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final checkbox = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: value
                      ? (activeColor ?? Theme.of(context).colorScheme.primary)
                      : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
                color: value
                    ? (activeColor ?? Theme.of(context).colorScheme.primary)
                    : Colors.transparent,
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(label!),
            ],
          ],
        ),
      ),
    );

    return checkbox;
  }
}





