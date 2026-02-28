import 'package:flutter/material.dart' as material;

class Slider extends material.StatefulWidget {
  final double value;
  final material.ValueChanged<double>? onChanged;
  final material.ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final material.Color? activeColor;
  final material.Color? inactiveColor;

  const Slider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeEnd,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  material.State<Slider> createState() => _SliderState();
}

class _SliderState extends material.State<Slider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Column(
      crossAxisAlignment: material.CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          material.Row(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            children: [
              material.Text(
                widget.label!,
                style: const material.TextStyle(fontSize: 14),
              ),
              material.Text(
                _currentValue.toInt().toString(),
                style: material.TextStyle(
                  fontSize: 14,
                  fontWeight: material.FontWeight.bold,
                  color: widget.activeColor ?? material.Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const material.SizedBox(height: 8),
        ],
        material.Material(
          color: material.Colors.transparent,
          child: material.SliderTheme(
            data: material.SliderTheme.of(context).copyWith(
              activeTrackColor: widget.activeColor ?? material.Theme.of(context).colorScheme.primary,
              inactiveTrackColor: widget.inactiveColor ?? material.Colors.grey[300],
              thumbColor: widget.activeColor ?? material.Theme.of(context).colorScheme.primary,
              overlayColor: (widget.activeColor ?? material.Theme.of(context).colorScheme.primary)
                  .withOpacity(0.2),
            ),
            child: material.Slider(
              value: _currentValue,
              min: widget.min,
              max: widget.max,
              divisions: widget.divisions,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChanged?.call(value);
              },
              onChangeEnd: (value) {
                widget.onChangeEnd?.call(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

