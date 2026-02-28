import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationItem> items;
  final ValueChanged<int> onTap;
  final Color? selectedColor;
  final Color? unselectedColor;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: selectedColor ?? Theme.of(context).colorScheme.primary,
      unselectedItemColor: unselectedColor ?? Colors.grey,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}

class BottomNavigationItem {
  final IconData icon;
  final String label;

  BottomNavigationItem({
    required this.icon,
    required this.label,
  });
}





