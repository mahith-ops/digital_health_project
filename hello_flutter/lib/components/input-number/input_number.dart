import 'package:flutter/material.dart';

class InputNumber extends StatefulWidget {
  final int? value;
  final ValueChanged<int>? onChanged;
  final String? label;
  final int? min;
  final int? max;
  final int step;

  const InputNumber({
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.min,
    this.max,
    this.step = 1,
  });

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString() ?? '0');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    final current = int.tryParse(_controller.text) ?? 0;
    final newValue = widget.max != null && current + widget.step > widget.max!
        ? widget.max!
        : current + widget.step;
    _updateValue(newValue);
  }

  void _decrement() {
    final current = int.tryParse(_controller.text) ?? 0;
    final newValue = widget.min != null && current - widget.step < widget.min!
        ? widget.min!
        : current - widget.step;
    _updateValue(newValue);
  }

  void _updateValue(int value) {
    setState(() {
      _controller.text = value.toString();
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                final current = int.tryParse(_controller.text) ?? 0;
                if (widget.min == null || current > widget.min!) {
                  _decrement();
                }
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  final intValue = int.tryParse(value);
                  if (intValue != null) {
                    widget.onChanged?.call(intValue);
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final current = int.tryParse(_controller.text) ?? 0;
                if (widget.max == null || current < widget.max!) {
                  _increment();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}





