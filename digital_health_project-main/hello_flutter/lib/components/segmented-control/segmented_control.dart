import 'package:flutter/material.dart';

class SegmentedControl<T> extends StatelessWidget {
  final List<SegmentItem<T>> segments;
  final T? selectedValue;
  final ValueChanged<T>? onValueChanged;
  final Color? selectedColor;
  final Color? unselectedColor;

  const SegmentedControl({
    super.key,
    required this.segments,
    this.selectedValue,
    this.onValueChanged,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: unselectedColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: segments.asMap().entries.map((entry) {
          final index = entry.key;
          final segment = entry.value;
          final isSelected = selectedValue == segment.value;
          final isFirst = index == 0;
          final isLast = index == segments.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () => onValueChanged?.call(segment.value),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? Theme.of(context).colorScheme.primary)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: isFirst ? const Radius.circular(8) : Radius.zero,
                    bottomLeft: isFirst ? const Radius.circular(8) : Radius.zero,
                    topRight: isLast ? const Radius.circular(8) : Radius.zero,
                    bottomRight: isLast ? const Radius.circular(8) : Radius.zero,
                  ),
                ),
                child: Center(
                  child: Text(
                    segment.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SegmentItem<T> {
  final T value;
  final String label;

  SegmentItem({
    required this.value,
    required this.label,
  });
}





