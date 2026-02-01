import 'package:flutter/material.dart';
import '../chip/chip.dart' as custom_chip;

class ChipGroup extends StatelessWidget {
  final List<String> chips;
  final ValueChanged<String>? onChipTap;
  final ValueChanged<String>? onChipDeleted;
  final int? selectedIndex;
  final Color? selectedColor;
  final Color? unselectedColor;

  const ChipGroup({
    super.key,
    required this.chips,
    this.onChipTap,
    this.onChipDeleted,
    this.selectedIndex,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips.asMap().entries.map((entry) {
        final index = entry.key;
        final chip = entry.value;
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: onChipTap != null ? () => onChipTap!(chip) : null,
          child: custom_chip.Chip(
            label: chip,
            color: isSelected
                ? (selectedColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))
                : (unselectedColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            textColor: isSelected
                ? (selectedColor ?? Theme.of(context).colorScheme.primary)
                : null,
            onDeleted: onChipDeleted != null
                ? () => onChipDeleted!(chip)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
