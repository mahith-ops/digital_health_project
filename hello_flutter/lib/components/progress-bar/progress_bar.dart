import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double? maxValue;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final String? label;

  const ProgressBar({
    super.key,
    required this.value,
    this.maxValue,
    this.color,
    this.backgroundColor,
    this.height,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final max = maxValue ?? 100;
    final percentage = (value / max).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height ?? 8,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color ?? Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





