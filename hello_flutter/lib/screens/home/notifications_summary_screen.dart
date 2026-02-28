import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF0F172A),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '2 unread',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'Mark all read',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _buildNotificationCard(
                context,
                type: NotificationType.medicationReminder,
                title: 'Medication Reminder',
                message: 'Time to take Aspirin 100mg',
                timestamp: '2 minutes ago',
                isUnread: true,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                context,
                type: NotificationType.upcomingAppointment,
                title: 'Upcoming Appointment',
                message: 'Dr. Sarah Johnson - Cardiology at 10:00 AM',
                timestamp: '1 hour ago',
                isUnread: true,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                context,
                type: NotificationType.lowStockAlert,
                title: 'Low Stock Alert',
                message: 'Metformin 500mg is running low. 1 refill needed.',
                timestamp: '3 hours ago',
                isUnread: false,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                context,
                type: NotificationType.dailyCheckIn,
                title: 'Daily Check-in',
                message: 'Don\'t forget to log your blood pressure today',
                timestamp: 'Yesterday',
                isUnread: false,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                context,
                type: NotificationType.systemUpdate,
                title: 'System Update',
                message: 'New features available. Update your app for the best experience.',
                timestamp: '2 days ago',
                isUnread: false,
              ),
              const SizedBox(height: 12),
              _buildNotificationCard(
                context,
                type: NotificationType.medicationReminder,
                title: 'Medication Reminder',
                message: 'Time to take Lisinopril 10mg',
                timestamp: '3 days ago',
                isUnread: false,
              ),
              const SizedBox(height: 80), // Bottom padding for navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required NotificationType type,
    required String title,
    required String message,
    required String timestamp,
    required bool isUnread,
  }) {
    final notificationData = _getNotificationData(type);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isUnread
            ? BorderSide(
                color: notificationData.color.withOpacity(0.2),
                width: 1.5,
              )
            : BorderSide.none,
      ),
      color: isUnread ? Colors.white : Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: notificationData.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notificationData.icon,
                    color: notificationData.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isUnread)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: notificationData.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _NotificationData _getNotificationData(NotificationType type) {
    switch (type) {
      case NotificationType.medicationReminder:
        return _NotificationData(
          icon: Icons.check_circle,
          color: const Color(0xFF10B981), // Green
        );
      case NotificationType.upcomingAppointment:
        return _NotificationData(
          icon: Icons.calendar_today,
          color: const Color(0xFF3B82F6), // Blue
        );
      case NotificationType.lowStockAlert:
        return _NotificationData(
          icon: Icons.inventory_2,
          color: const Color(0xFFF59E0B), // Orange
        );
      case NotificationType.dailyCheckIn:
        return _NotificationData(
          icon: Icons.notifications,
          color: const Color(0xFF8B5CF6), // Purple
        );
      case NotificationType.systemUpdate:
        return _NotificationData(
          icon: Icons.info,
          color: const Color(0xFF6B7280), // Gray
        );
    }
  }
}

enum NotificationType {
  medicationReminder,
  upcomingAppointment,
  lowStockAlert,
  dailyCheckIn,
  systemUpdate,
}

class _NotificationData {
  final IconData icon;
  final Color color;

  _NotificationData({
    required this.icon,
    required this.color,
  });
}
