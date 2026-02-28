import 'package:flutter/material.dart';

/// Medication Stock Screen
/// Displays a list of medicines with quantities and allows filtering.
/// UI-only implementation with no backend logic.
class MedicationStockPage extends StatefulWidget {
  const MedicationStockPage({super.key});

  @override
  State<MedicationStockPage> createState() => _MedicationStockPageState();
}

class _MedicationStockPageState extends State<MedicationStockPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Low Stock'];

  // Hardcoded medicine list
  final List<Map<String, dynamic>> _medicines = [
    {
      'name': 'Aspirin 100mg',
      'frequency': 'Once daily',
      'quantity': 25,
      'unit': 'Caps',
      'isLowStock': false,
    },
    {
      'name': 'Vitamin D',
      'frequency': 'Once daily',
      'quantity': 15,
      'unit': 'Caps',
      'isLowStock': false,
    },
    {
      'name': 'Eye Drops',
      'frequency': 'Twice daily',
      'quantity': 3,
      'unit': 'Caps',
      'isLowStock': true,
    },
  ];

  void _handleBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                _buildSearchBar(),
                const SizedBox(height: 20),

                // Filter pills
                _buildFilterPills(),
                const SizedBox(height: 24),

                // Medicine list
                _buildMedicineList(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingAddButton(),
    );
  }

  /// Builds the app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: _handleBack,
      ),
      title: const Text(
        'Medication Stock',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }

  /// Builds the search bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search medicines…',
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFBDBDBD),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              Icons.search,
              size: 20,
              color: Color(0xFFBDBDBD),
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Builds the filter pills
  Widget _buildFilterPills() {
    return Row(
      children: _filters.map((filter) {
        final isActive = _selectedFilter == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF0097A7)
                    : const Color(0xFFE8EBED),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds the medicine list
  Widget _buildMedicineList() {
    return Column(
      children: _medicines.map((medicine) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMedicineCard(
            medicineName: medicine['name'],
            frequency: medicine['frequency'],
            quantity: medicine['quantity'],
            unit: medicine['unit'],
            isLowStock: medicine['isLowStock'],
          ),
        );
      }).toList(),
    );
  }

  /// Builds a single medicine card
  Widget _buildMedicineCard({
    required String medicineName,
    required String frequency,
    required int quantity,
    required String unit,
    required bool isLowStock,
  }) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Left: Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 24,
                  color: Color(0xFF0097A7),
                ),
              ),
              const SizedBox(width: 16),

              // Center: Medicine info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicineName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      frequency,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Right: Quantity and unit
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  if (isLowStock) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE0B2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'LOW',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF57C00),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the floating add button
  Widget _buildFloatingAddButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        // UI only, no action
      },
      backgroundColor: const Color(0xFF0097A7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      icon: const Icon(Icons.add, size: 24, color: Colors.white),
      label: const Text(
        'Add Medicine',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}