import 'package:flutter/material.dart';
import 'package:hello_flutter/components/button/button.dart';
import 'package:hello_flutter/components/date-picker/date_picker.dart';
import 'package:hello_flutter/components/dropdown/dropdown.dart';
import 'package:hello_flutter/components/text-area/text_area.dart';
import 'package:hello_flutter/components/switch/switch.dart' as custom_switch;
import 'package:hello_flutter/components/file-upload/file_upload.dart';
import 'package:hello_flutter/screens/add/add_record_reminder_medication.dart';

/// Add Record Screen
/// Allows users to manually add medical records with custom components.
/// UI-only implementation with no validation or backend logic.
class AddRecordScreenPage extends StatefulWidget {
  final VoidCallback? onNavigateToReminder;
  final VoidCallback? onNavigateToMedication;

  const AddRecordScreenPage({
    super.key,
    this.onNavigateToReminder,
    this.onNavigateToMedication,
  });

  @override
  State<AddRecordScreenPage> createState() => _AddRecordScreenPageState();
}

class _AddRecordScreenPageState extends State<AddRecordScreenPage> {
  // Record type selection state
  String _selectedRecordType = 'Prescription';

  final List<String> _recordTypes = [
    'Prescription',
    'Lab Report',
    'Reminder',
    'Medicine Stock',
  ];

  // Form field states
  String? _selectedCategory;
  String? _selectedDoctor;
  DateTime? _dateOfVisit;
  String _notes = '';
  DateTime? _nextAppointmentDate;
  bool _remindMe = false;

  // Category options
  final List<DropdownItem<String>> _categoryOptions = [
    DropdownItem(value: 'Cardiology', label: 'Cardiology'),
    DropdownItem(value: 'Dermatology', label: 'Dermatology'),
    DropdownItem(value: 'Neurology', label: 'Neurology'),
    DropdownItem(value: 'Orthopedics', label: 'Orthopedics'),
    DropdownItem(value: 'Pediatrics', label: 'Pediatrics'),
  ];

  // Doctor options
  final List<DropdownItem<String>> _doctorOptions = [
    DropdownItem(value: 'Dr. Smith', label: 'Dr. Smith'),
    DropdownItem(value: 'Dr. Johnson', label: 'Dr. Johnson'),
    DropdownItem(value: 'Dr. Williams', label: 'Dr. Williams'),
    DropdownItem(value: 'Dr. Brown', label: 'Dr. Brown'),
  ];

  void _handleSaveRecord() {
    // UI only, no validation logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Record saved successfully!'),
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
                    // Record type selector tabs
                    _buildRecordTypeTabs(),
                    const SizedBox(height: 24),

                    // Category field
                    Dropdown<String>(
                      label: 'Category',
                      value: _selectedCategory,
                      items: _categoryOptions,
                      hint: 'Type to search or select (e.g. Cardiology)',
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // UI only, no logic
                      },
                      child: const Text(
                        '+ Add new category',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF0097A7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Doctor name field
                    Dropdown<String>(
                      label: 'Doctor Name',
                      value: _selectedDoctor,
                      items: _doctorOptions,
                      hint: 'Type to search or select (e.g. Dr. Smith)',
                      onChanged: (value) {
                        setState(() {
                          _selectedDoctor = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // UI only, no logic
                      },
                      child: const Text(
                        '+ Add new doctor',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF0097A7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Date of visit field
                    DatePicker(
                      label: 'Date of Visit',
                      selectedDate: _dateOfVisit,
                      onDateSelected: (date) {
                        setState(() {
                          _dateOfVisit = date;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Document upload
                    FileUpload(
                      label: 'Documents',
                      acceptedTypes: ['pdf', 'jpg', 'png'],
                      onFileSelected: (file) {
                        // UI only, no logic
                      },
                    ),
                    const SizedBox(height: 24),

                    // Notes section
                    TextArea(
                      label: 'Notes / Comments',
                      hint: 'Add personal notes…',
                      value: _notes,
                      onChanged: (value) {
                        setState(() {
                          _notes = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Next appointment section
                    DatePicker(
                      label: 'Next Appointment',
                      selectedDate: _nextAppointmentDate,
                      onDateSelected: (date) {
                        setState(() {
                          _nextAppointmentDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Reminder toggle
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            size: 20,
                            color: Color(0xFF0097A7),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Remind me',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Get a notification before visit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          custom_switch.Switch(
                            value: _remindMe,
                            onChanged: (value) {
                              setState(() {
                                _remindMe = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Save button at bottom
            Container(
              padding: const EdgeInsets.all(16),
              child: Button(
                label: 'Save Record',
                onPressed: _handleSaveRecord,
                type: ButtonType.primary,
                size: ButtonSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar with back button, title, and cancel button
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

  /// Builds the record type selector tabs in a 2x2 grid
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
            if (type == 'Reminder' && widget.onNavigateToReminder != null) {
              widget.onNavigateToReminder!();
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
                  ? const Color(0xFF0097A7) // Teal/cyan accent
                  : const Color(0xFFE8EBED), // Light gray
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
}

/// Alias for backward compatibility
typedef AddRecordScreen = AddRecordScreenPage;