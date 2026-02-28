import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool barrierDismissible;

  const Dialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.barrierDismissible = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        title: title,
        content: content,
        actions: actions,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions ??
          [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
    );
  }
}





