import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final String? label;

  const TimePicker({
    super.key,
    this.selectedTime,
    this.onTimeSelected,
    this.label,
  });

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && onTimeSelected != null) {
      onTimeSelected!(picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

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
        InkWell(
          onTap: () => _selectTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTime != null
                      ? _formatTime(selectedTime!)
                      : 'Select time',
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedTime != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.access_time, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





