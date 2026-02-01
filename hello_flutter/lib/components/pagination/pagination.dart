import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;
  final int visiblePages;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPageChanged,
    this.visiblePages = 5,
  });

  @override
  Widget build(BuildContext context) {
    final pages = _getVisiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1
              ? () => onPageChanged?.call(currentPage - 1)
              : null,
        ),
        ...pages.map((page) {
          final isCurrentPage = page == currentPage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Material(
              color: isCurrentPage
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => onPageChanged?.call(page),
                customBorder: const CircleBorder(),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    '$page',
                    style: TextStyle(
                      color: isCurrentPage ? Colors.white : Colors.black,
                      fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages
              ? () => onPageChanged?.call(currentPage + 1)
              : null,
        ),
      ],
    );
  }

  List<int> _getVisiblePages() {
    final pages = <int>[];
    final halfVisible = visiblePages ~/ 2;

    int start = currentPage - halfVisible;
    int end = currentPage + halfVisible;

    if (start < 1) {
      end += (1 - start);
      start = 1;
    }

    if (end > totalPages) {
      start -= (end - totalPages);
      end = totalPages;
      if (start < 1) start = 1;
    }

    for (int i = start; i <= end; i++) {
      pages.add(i);
    }

    return pages;
  }
}





