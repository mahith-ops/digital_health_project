import 'package:flutter/material.dart';

class Table extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final bool striped;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;

  const Table({
    super.key,
    required this.headers,
    required this.rows,
    this.striped = false,
    this.headerBackgroundColor,
    this.headerTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: headerBackgroundColor ?? Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: headers.asMap().entries.map((entry) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: headerTextColor ?? Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Rows
          ...rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            final isEven = striped && index % 2 == 0;

            return Container(
              color: isEven ? Colors.grey[50] : Colors.white,
              child: Row(
                children: row.map((cell) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: cell,
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}





