import 'package:flutter/material.dart';
import 'package:hello_flutter/screens/home/home_screen.dart';
import 'package:hello_flutter/screens/home/Medical_history.dart';
import 'package:hello_flutter/screens/reminders/reminders_home_screen.dart';
import 'package:hello_flutter/screens/settings/settings_home_screen.dart';
import 'package:hello_flutter/components/bottom-navigation/bottom_navigation.dart';
import 'package:hello_flutter/screens/add/add_record_prescription.dart';
import 'package:hello_flutter/screens/add/add_record_medication.dart';
import 'package:hello_flutter/screens/add/add_record_reminder_medication.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomePage(),
      const MedicalHistory(),
      const AddRecordsContainer(),
      const RemindersScreen(),
      const SettingsScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final items = [
      BottomNavigationItem(
        icon: Icons.home,
        label: 'Home',
      ),
      BottomNavigationItem(
        icon: Icons.history,
        label: 'History',
      ),
      BottomNavigationItem(
        icon: Icons.add_circle,
        label: 'Add',
      ),
      BottomNavigationItem(
        icon: Icons.notifications_outlined,
        label: 'Reminders',
      ),
      BottomNavigationItem(
        icon: Icons.settings,
        label: 'Settings',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: items,
      ),
    );
  }
}

/// Container widget that manages navigation between all add record screens
class AddRecordsContainer extends StatefulWidget {
  const AddRecordsContainer({super.key});

  @override
  State<AddRecordsContainer> createState() => _AddRecordsContainerState();
}

class _AddRecordsContainerState extends State<AddRecordsContainer> {
  String _currentScreen = 'Prescription'; // 'Prescription', 'Medication', 'Reminder'

  void _navigateTo(String screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case 'Prescription':
        return AddRecordScreenWrapper(
          onNavigate: _navigateTo,
        );
      case 'Medication':
        return MedicineStockPageWrapper(
          onNavigate: _navigateTo,
        );
      case 'Reminder':
        return AddMedicationRecordScreenWrapper(
          onNavigate: _navigateTo,
        );
      default:
        return AddRecordScreenWrapper(
          onNavigate: _navigateTo,
        );
    }
  }
}

/// Wrapper for AddRecordScreen to accept navigation callback
class AddRecordScreenWrapper extends StatefulWidget {
  final Function(String) onNavigate;

  const AddRecordScreenWrapper({super.key, required this.onNavigate});

  @override
  State<AddRecordScreenWrapper> createState() => _AddRecordScreenWrapperState();
}

class _AddRecordScreenWrapperState extends State<AddRecordScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return AddRecordScreenPage(
      onNavigateToReminder: () => widget.onNavigate('Reminder'),
      onNavigateToMedication: () => widget.onNavigate('Medication'),
    );
  }
}

/// Wrapper for MedicineStockPage to accept navigation callback
class MedicineStockPageWrapper extends StatefulWidget {
  final Function(String) onNavigate;

  const MedicineStockPageWrapper({super.key, required this.onNavigate});

  @override
  State<MedicineStockPageWrapper> createState() =>
      _MedicineStockPageWrapperState();
}

class _MedicineStockPageWrapperState extends State<MedicineStockPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return MedicineStockPageWithNavigation(
      onNavigateToPrescription: () => widget.onNavigate('Prescription'),
      onNavigateToReminder: () => widget.onNavigate('Reminder'),
    );
  }
}

/// Wrapper for AddMedicationRecordScreen to accept navigation callback
class AddMedicationRecordScreenWrapper extends StatefulWidget {
  final Function(String) onNavigate;

  const AddMedicationRecordScreenWrapper({
    super.key,
    required this.onNavigate,
  });

  @override
  State<AddMedicationRecordScreenWrapper> createState() =>
      _AddMedicationRecordScreenWrapperState();
}

class _AddMedicationRecordScreenWrapperState
    extends State<AddMedicationRecordScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return AddMedicationRecordScreenWithNavigation(
      onNavigateToPrescription: () => widget.onNavigate('Prescription'),
      onNavigateToMedication: () => widget.onNavigate('Medication'),
    );
  }
}