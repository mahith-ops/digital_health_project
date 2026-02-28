import 'package:flutter/material.dart';

/// Medicine Stock Add Record Screen
/// Allows users to manually add medicine stock information.
/// UI-only implementation with no validation or backend logic.
class MedicineStockPageWithNavigation extends StatefulWidget {
  final VoidCallback? onNavigateToPrescription;
  final VoidCallback? onNavigateToReminder;

  const MedicineStockPageWithNavigation({
    super.key,
    this.onNavigateToPrescription,
    this.onNavigateToReminder,
  });

  @override
  State<MedicineStockPageWithNavigation> createState() =>
      _MedicineStockPageWithNavigationState();
}

class _MedicineStockPageWithNavigationState
    extends State<MedicineStockPageWithNavigation> {
  // Record type selection
  String _selectedRecordType = 'Medicine Stock';

  final List<String> _recordTypes = [
    'Prescription',
    'Lab Report',
    'Reminder',
    'Medicine Stock',
  ];

  // Form field states
  // ignore: unused_field
  String _medicineName = '';
  // ignore: unused_field
  String _medicineType = '';
  // ignore: unused_field
  String _dosageDescription = '';
  // ignore: unused_field
  String _quantity = '';

  void _handleSaveRecord() {
    // UI only, no validation or logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicine stock saved successfully!'),
      ),
    );
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Record type tabs
                    _buildRecordTypeTabs(),
                    const SizedBox(height: 24),

                    // Medicine name field
                    _buildMedicineNameField(),
                    const SizedBox(height: 16),

                    // Medicine type field
                    _buildMedicineTypeField(),
                    const SizedBox(height: 16),

                    // Dosage / Description field
                    _buildDosageDescriptionField(),
                    const SizedBox(height: 16),

                    // Quantity field
                    _buildQuantityField(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Save button at bottom
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0097A7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _handleSaveRecord,
                  child: const Text(
                    'Save Record',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: _handleCancel,
      ),
      title: const Text(
        'Add Record',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: _handleCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the record type tabs (category selector)
  Widget _buildRecordTypeTabs() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: _recordTypes.map((type) {
        final isActive = _selectedRecordType == type;
        return GestureDetector(
          onTap: () {
            // Navigate to respective screens when tapped
            if (type == 'Prescription' && widget.onNavigateToPrescription != null) {
              widget.onNavigateToPrescription!();
            } else if (type == 'Reminder' && widget.onNavigateToReminder != null) {
              widget.onNavigateToReminder!();
            } else {
              setState(() {
                _selectedRecordType = type;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF0097A7)
                  : const Color(0xFFE8EBED),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.white : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds medicine name field
  Widget _buildMedicineNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Medicine Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _medicineName = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Type to search or select (e.g., Aspirin)',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBDBDBD),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.arrow_drop_down,
                    size: 24, color: Colors.grey.shade400),
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds medicine type field
  Widget _buildMedicineTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Medicine Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _medicineType = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter medicine type',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBDBDBD),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds dosage/description field
  Widget _buildDosageDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dosage / Description',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _dosageDescription = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'e.g., 20mg • Take 1 daily',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBDBDBD),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds quantity field
  Widget _buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _quantity = value;
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g., 30 tablets',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFBDBDBD),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

/// Alias for backward compatibility
typedef MedicineStockPage = MedicineStockPageWithNavigation;