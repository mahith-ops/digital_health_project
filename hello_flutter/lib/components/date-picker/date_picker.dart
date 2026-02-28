import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String? label;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePicker({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.label,
    this.firstDate,
    this.lastDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (picked != null && onDateSelected != null) {
      onDateSelected!(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}





