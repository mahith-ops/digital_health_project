import 'package:flutter/material.dart';

/// Past Consultations Screen
/// Displays a list of past consultations for a doctor, grouped by date.
/// Shows related prescriptions/documents and notes.
class PastConsultationsPage extends StatelessWidget {
  const PastConsultationsPage({super.key});

  // Hardcoded sample consultation data
  static final List<Map<String, dynamic>> _consultations = [
    {
      'date': '15/12/2025',
      'hasDocuments': true,
      'notes': 'Follow up in 3 months',
    },
    {
      'date': '10/11/2025',
      'hasDocuments': true,
      'notes': 'Continue current medication',
    },
    {
      'date': '25/09/2025',
      'hasDocuments': true,
      'notes': 'Schedule blood tests',
    },
    {
      'date': '15/08/2025',
      'hasDocuments': false,
      'notes': 'Initial consultation',
    },
  ];

  void _handleBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Consultation cards
              ..._consultations.map((consultation) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildConsultationCard(
                    date: consultation['date'],
                    hasDocuments: consultation['hasDocuments'],
                    notes: consultation['notes'],
                  ),
                );
              }).toList(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => _handleBack(context),
      ),
      title: const Text(
        'Past Consultations',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
    );
  }

  /// Builds a consultation card
  Widget _buildConsultationCard({
    required String date,
    required bool hasDocuments,
    required String notes,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date section
              _buildDateSection(date),
              const SizedBox(height: 16),

              // Documents button
              if (hasDocuments) ...[
                _buildDocumentsButton(),
                const SizedBox(height: 16),
              ],

              // Notes section
              _buildNotesSection(notes),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the date section
  Widget _buildDateSection(String date) {
    return Row(
      children: [
        Text(
          'Date : ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  /// Builds the prescription/documents button
  Widget _buildDocumentsButton() {
    return InkWell(
      onTap: () {
        // UI only, no action yet
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          border: Border.all(
            color: const Color(0xFF4CAF50),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Prescription or documents',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the notes section
  Widget _buildNotesSection(String notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Notes : ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
              ),
            ),
            Expanded(
              child: Text(
                notes,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}