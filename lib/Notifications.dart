import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:turf_nest/home.dart';
import 'package:turf_nest/models/notifications_model.dart';

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

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<turfhistory_model> fullhistory = [];

  turfhistory_model? singlehistory;

  @override
  void initState() {
    super.initState();

    getsport();
  }

  getsport() async {
    fullhistory = await FirebaseFirestoreHelper.instance.getTurfHistory();
    setState(() {});
  }

  String convertTo12HourFormat(int hour) {
    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
    }
    if (hour > 12) {
      hour -= 12;
    }
    return '$hour $period';
  }

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
            itemCount: fullhistory.length,
            itemBuilder: (context, index) {
              final singlehistory = fullhistory[index];
              return GestureDetector(
                onTap: () {
                  // Add your singlehistory tap logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification ID: ${index+1}'),
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
                            'Ticket no: ${singlehistory.ticketid}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Time:' +
                          convertTo12HourFormat(singlehistory.time) +
                          " - " +
                          convertTo12HourFormat(singlehistory.time + 1)),
                      Text('Date: ${singlehistory.date.substring(0,11)}'),
                      Text('Activation Time: ${singlehistory.activationTime.substring(0,19)}'),
                      Text('Price: ${singlehistory.price}'),
                      Text('Sport: ${singlehistory.sport}'),
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
