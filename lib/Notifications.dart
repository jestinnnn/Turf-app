import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/home.dart';

class Notification {
  final int id;
  final String message;
  final bool isActive;

  Notification({
    required this.id,
    required this.message,
    required this.isActive,
  });
}

class NotificationsScreen extends StatelessWidget {
  final List<Notification> notifications = [
    Notification(id: 1, message: 'Your booking is confirmed.', isActive: true),
    Notification(id: 2, message: 'New offers available!', isActive: true),
    Notification(id: 3, message: 'Payment received.', isActive: true),
    Notification(
        id: 4, message: 'Update your profile information.', isActive: false),
    Notification(
        id: 5, message: 'Event reminder: Tomorrow at 10 AM.', isActive: true),
    Notification(
        id: 6, message: 'Your account has been credited.', isActive: false),
    Notification(
        id: 7, message: 'Check out our latest blog post.', isActive: true),
  ];

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double middleHeight = screenHeight * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          color: AppColors.blue,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            width: screenWidth,
            height: 0.4 * screenHeight,
            child: Container(
              height: middleHeight,
              color: AppColors.blue,
            ),
          ),
          ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return GestureDetector(
                onTap: () {
                  // Add your notification tap logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification ID: ${notification.id}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notification ID: ${notification.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: notification.isActive
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(notification.message),
                      Text(
                          'Status: ${notification.isActive ? 'Active' : 'Inactive'}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
