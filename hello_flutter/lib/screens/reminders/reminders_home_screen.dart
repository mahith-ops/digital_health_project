import 'package:flutter/material.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Meds', 'Visits'];

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
              const SizedBox(height: 28),
              _buildDailyAdherenceCard(context),
              const SizedBox(height: 28),
              _buildDateSelector(context),
              const SizedBox(height: 24),
              _buildFilterTabs(context),
              const SizedBox(height: 24),
              _buildMedicationSections(context),
              const SizedBox(height: 80), // Bottom spacing for navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reminders',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 18),
              SizedBox(width: 6),
              Text(
                'Add Reminder',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyAdherenceCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Adherence',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.75,
                minHeight: 8,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF10B981),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "You're doing great today!",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF10B981),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final currentMonth = monthNames[_selectedDate.month - 1];
    final currentYear = _selectedDate.year;
    final monthLabel = '$currentMonth $currentYear';

    // Generate dates for the current month
    final firstDay = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDay = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final daysInMonth = lastDay.day;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              monthLabel,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        _selectedDate.day,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_left),
                  color: Colors.grey[700],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        _selectedDate.day,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_right),
                  color: Colors.grey[700],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              final date = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                index + 1,
              );
              final isSelected = date.day == _selectedDate.day &&
                  date.month == _selectedDate.month &&
                  date.year == _selectedDate.year;
              final isToday = date.day == DateTime.now().day &&
                  date.month == DateTime.now().month &&
                  date.year == DateTime.now().year;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  width: 50,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF10B981)
                        : (isToday
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : Colors.grey[100]),
                    borderRadius: BorderRadius.circular(12),
                    border: isToday && !isSelected
                        ? Border.all(
                            color: const Color(0xFF10B981),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Row(
      children: List.generate(
        _filters.length,
        (index) => Padding(
          padding: EdgeInsets.only(right: index < _filters.length - 1 ? 8 : 0),
          child: ChoiceChip(
            label: Text(_filters[index]),
            selected: _selectedFilterIndex == index,
            onSelected: (selected) {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            selectedColor: const Color(0xFF10B981),
            labelStyle: TextStyle(
              color: _selectedFilterIndex == index
                  ? Colors.white
                  : const Color(0xFF0F172A),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            backgroundColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMedicationSection(
          context,
          'Morning',
          Icons.wb_sunny_outlined,
          [
            _MedicationData(
              name: 'Aspirin 100mg',
              dosage: '1 tablet',
              time: '08:00 AM',
              status: MedicationStatus.dueNow,
            ),
            _MedicationData(
              name: 'Metformin 500mg',
              dosage: '1 tablet',
              time: '09:00 AM',
              status: MedicationStatus.taken,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildMedicationSection(
          context,
          'Afternoon',
          Icons.wb_twilight_outlined,
          [
            _MedicationData(
              name: 'Lisinopril 10mg',
              dosage: '1 tablet',
              time: '12:00 PM',
              status: MedicationStatus.dueNow,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildMedicationSection(
          context,
          'Evening',
          Icons.nightlight_outlined,
          [
            _MedicationData(
              name: 'Atorvastatin 20mg',
              dosage: '1 tablet',
              time: '06:00 PM',
              status: MedicationStatus.missed,
            ),
            _MedicationData(
              name: 'Vitamin D3',
              dosage: '1 capsule',
              time: '08:00 PM',
              status: MedicationStatus.dueNow,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMedicationSection(
    BuildContext context,
    String title,
    IconData icon,
    List<_MedicationData> medications,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.grey[700],
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...medications.map((med) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildMedicationCard(context, med),
            )),
      ],
    );
  }

  Widget _buildMedicationCard(BuildContext context, _MedicationData medication) {
    Color statusColor;
    String statusText;
    switch (medication.status) {
      case MedicationStatus.taken:
        statusColor = const Color(0xFF10B981);
        statusText = 'TAKEN';
        break;
      case MedicationStatus.dueNow:
        statusColor = const Color(0xFFF59E0B);
        statusText = 'DUE NOW';
        break;
      case MedicationStatus.missed:
        statusColor = const Color(0xFFEF4444);
        statusText = 'MISSED';
        break;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${medication.dosage} · ${medication.time}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 11,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            if (medication.status != MedicationStatus.taken) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Snooze',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        medication.status == MedicationStatus.missed
                            ? 'Mark as Taken'
                            : 'Take',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum MedicationStatus {
  taken,
  dueNow,
  missed,
}

class _MedicationData {
  final String name;
  final String dosage;
  final String time;
  final MedicationStatus status;

  _MedicationData({
    required this.name,
    required this.dosage,
    required this.time,
    required this.status,
  });
}
