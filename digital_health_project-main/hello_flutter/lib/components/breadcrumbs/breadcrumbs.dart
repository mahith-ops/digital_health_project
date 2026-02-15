import 'package:flutter/material.dart';

class Breadcrumbs extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String>? onItemTap;
  final Widget? separator;

  const Breadcrumbs({
    super.key,
    required this.items,
    this.onItemTap,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          GestureDetector(
            onTap: onItemTap != null ? () => onItemTap!(items[i]) : null,
            child: Text(
              items[i],
              style: TextStyle(
                color: i == items.length - 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontWeight: i == items.length - 1 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (i < items.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: separator ?? Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ),
        ],
      ],
    );
  }
}





