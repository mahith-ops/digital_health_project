import 'package:flutter/material.dart';
import 'package:hello_flutter/components/avatar/avatar.dart';
import 'package:hello_flutter/components/button/button.dart';
import 'package:hello_flutter/components/card/card.dart' as ds;
import 'package:hello_flutter/components/search-input/search_input.dart';
import 'package:hello_flutter/components/chip/chip.dart' as chip_component;
import 'package:hello_flutter/screens/medical_history/medical_history_doctor.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  int _selectedFilterIndex = 0;
  final List<String> _filterOptions = ['All', 'General', 'Dentist', 'Cardio'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildSearchBar(context),
              const SizedBox(height: 20),
              _buildFilterChips(context),
              const SizedBox(height: 28),
              _buildRecentlyVisitedSection(context),
              const SizedBox(height: 16),
              _buildDoctorCard(
                context,
                'DJ',
                'Dr. John Smith',
                'General Practitioner',
                'March 15, 2024',
                const Color(0xFF3B82F6),
              ),
              const SizedBox(height: 12),
              _buildDoctorCard(
                context,
                'DC',
                'Dr. Emily Chen',
                'Cardiology',
                'March 10, 2024',
                const Color(0xFF6366F1),
              ),
              const SizedBox(height: 12),
              _buildDoctorCard(
                context,
                'DM',
                'Dr. Michael Brown',
                'Dentist',
                'March 5, 2024',
                const Color(0xFF10B981),
              ),
              const SizedBox(height: 12),
              _buildDoctorCard(
                context,
                'DS',
                'Dr. Sarah Johnson',
                'Cardiology',
                'February 28, 2024',
                const Color(0xFF8B5CF6),
              ),
              const SizedBox(height: 12),
              _buildDoctorCard(
                context,
                'DR',
                'Dr. Robert Lee',
                'General Practitioner',
                'February 20, 2024',
                const Color(0xFFF59E0B),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Medical History',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
            letterSpacing: -0.3,
          ),
        ),
        Button(
          label: '+ Add Record',
          type: ButtonType.primary,
          size: ButtonSize.medium,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchInput(
      hint: 'Search doctors, specialties…',
      onChanged: (value) {},
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: index < _filterOptions.length - 1 ? 8 : 0),
              child: chip_component.Chip(
                label: _filterOptions[index],
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : Colors.grey[200],
                textColor: isSelected
                    ? Colors.white
                    : Colors.grey[700],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentlyVisitedSection(BuildContext context) {
    return Text(
      'RECENTLY VISITED',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    String initials,
    String doctorName,
    String specialty,
    String lastVisit,
    Color avatarColor,
  ) {
    return ds.Card(
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailsPage(
              doctorName: doctorName,
              specialization: specialty,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Avatar(
            initials: initials,
            size: 56,
            backgroundColor: avatarColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  lastVisit,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: 24,
          ),
        ],
      ),
    );
  }
}
