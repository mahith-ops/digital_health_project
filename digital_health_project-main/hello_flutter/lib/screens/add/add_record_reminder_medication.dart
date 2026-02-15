import 'package:flutter/material.dart';

/// Add Medication Reminder Record Screen
/// Allows users to manually add medication reminders.
/// UI-only implementation with no validation or backend logic.
class AddMedicationRecordScreenWithNavigation extends StatefulWidget {
  final VoidCallback? onNavigateToPrescription;
  final VoidCallback? onNavigateToMedication;

  const AddMedicationRecordScreenWithNavigation({
    super.key,
    this.onNavigateToPrescription,
    this.onNavigateToMedication,
  });

  @override
  State<AddMedicationRecordScreenWithNavigation> createState() =>
      _AddMedicationRecordScreenWithNavigationState();
}

class _AddMedicationRecordScreenWithNavigationState
    extends State<AddMedicationRecordScreenWithNavigation> {
  // Record type selection (top level tabs)
  String _selectedRecordType = 'Reminder';

  final List<String> _recordTypes = [
    'Prescription',
    'Lab Report',
    'Reminder',
    'Medicine Stock',
  ];

  // Record subtype selection (cards)
  String _selectedSubType = 'Medication';

  final List<String> _subTypes = ['Medication', 'Appointment'];

  // Form field states
  String _medicationName = '';
  DateTime? _fromDate;
  DateTime? _toDate;
  String _selectedTiming = 'Before Breakfast';
  String _selectedFrequency = 'Daily';
  String _medicineType = '';
  String _dosage = '';
  String _notes = '';

  // Timing options
  final List<String> _timingOptions = [
    'Before Breakfast',
    'After Breakfast',
    'Before Lunch',
    'After Lunch',
    'Before Dinner',
    'After Dinner',
  ];

  // Frequency options
  final List<String> _frequencyOptions = ['Daily', 'Weekly', 'As needed'];

  void _handleSaveRecord() {
    // UI only, no validation or logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medication reminder saved successfully!'),
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
                    const SizedBox(height: 16),

                    // Record subtype cards
                    _buildRecordSubTypeCards(),
                    const SizedBox(height: 24),

                    // Medication name field
                    _buildMedicationNameField(),
                    const SizedBox(height: 20),

                    // Date range fields
                    _buildDateRangeFields(),
                    const SizedBox(height: 24),

                    // Timing selection
                    _buildTimingLabel(),
                    const SizedBox(height: 12),
                    _buildTimingGrid(),
                    const SizedBox(height: 24),

                    // Frequency selection
                    _buildFrequencyLabel(),
                    const SizedBox(height: 12),
                    _buildFrequencyPills(),
                    const SizedBox(height: 24),

                    // Medicine type field
                    _buildMedicineTypeField(),
                    const SizedBox(height: 20),

                    // Dosage field
                    _buildDosageField(),
                    const SizedBox(height: 20),

                    // Notes field
                    _buildNotesField(),
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
                      borderRadius: BorderRadius.circular(12),
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
      backgroundColor: const Color(0xFFF8FAFC),
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

  /// Builds the record type tabs (top level)
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
            } else if (type == 'Medicine Stock' && widget.onNavigateToMedication != null) {
              widget.onNavigateToMedication!();
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

  /// Builds the record subtype cards
  Widget _buildRecordSubTypeCards() {
    return Row(
      children: _subTypes.map((subtype) {
        final isActive = _selectedSubType == subtype;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedSubType = subtype;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFE0F7FA)
                    : const Color(0xFFF5F5F5),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFF0097A7)
                      : const Color(0xFFE0E0E0),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    subtype == 'Medication'
                        ? Icons.medication
                        : Icons.calendar_today,
                    size: 28,
                    color: isActive
                        ? const Color(0xFF0097A7)
                        : Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtype,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive ? const Color(0xFF0097A7) : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds medication name field
  Widget _buildMedicationNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Medication Name',
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
                _medicationName = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Medication Name',
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

  /// Builds date range fields (From and To)
  Widget _buildDateRangeFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date Range',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'From Date',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDBDBD),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'To Date',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDBDBD),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds timing label
  Widget _buildTimingLabel() {
    return const Text(
      'Timing',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  /// Builds timing grid (6 pills)
  Widget _buildTimingGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: _timingOptions.map((timing) {
        final isActive = _selectedTiming == timing;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTiming = timing;
            });
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
                timing,
                style: TextStyle(
                  fontSize: 13,
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

  /// Builds frequency label
  Widget _buildFrequencyLabel() {
    return const Text(
      'Frequency',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  /// Builds frequency pills (horizontal)
  Widget _buildFrequencyPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _frequencyOptions.map((frequency) {
          final isActive = _selectedFrequency == frequency;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFrequency = frequency;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF0097A7)
                      : const Color(0xFFE8EBED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  frequency,
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
      ),
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
              hintText: 'Medicine Type',
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

  /// Builds dosage field
  Widget _buildDosageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dosage',
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
                _dosage = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'e.g., 1, 2',
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

  /// Builds notes field
  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes (optional)',
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
            maxLines: 4,
            onChanged: (value) {
              setState(() {
                _notes = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Add any notes…',
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
typedef AddMedicationRecordScreen = AddMedicationRecordScreenWithNavigation;