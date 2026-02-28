import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final Widget? action;

  const EmptyContent({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            if (message != null) ...[
              Text(
                message!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}

