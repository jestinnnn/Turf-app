import 'package:flutter/material.dart';

import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:turf_nest/models/ticket_model.dart';
import 'package:turf_nest/profile.dart';
import 'package:turf_nest/profile_components/qrpage.dart';
import 'package:turf_nest/routes.dart';

class Ticket {
  final int id;
  final DateTime bookedTime;
  final DateTime bookedDate;
  final bool isActive;

  Ticket({
    required this.id,
    required this.bookedTime,
    required this.bookedDate,
    required this.isActive,
  });
}

class BookedTicketsScreen extends StatefulWidget {
  @override
  State<BookedTicketsScreen> createState() => _BookedTicketsScreenState();
}

class _BookedTicketsScreenState extends State<BookedTicketsScreen> {
  bool isloading = false;
  List<ticket_Model> tickethistory = [];
  double animatedContainerHeight = 0;
  bool isAnimatedWidgetVisible = false;

  ticket_Model? singlehistory;

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
  void initState() {
    super.initState();
    getcategorylist();
  }

  void getcategorylist() async {
    setState(() {
      isloading = true;
    });
    tickethistory = await FirebaseFirestoreHelper.instance.getticket();

    setState(() {
      isloading = false;
    });
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
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
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
            height: 0.25 * screenHeight,
            child: Container(
              height: middleHeight,
              color: AppColors.blue,
            ),
          ),
          ListView.builder(
            itemCount: tickethistory.length,
            itemBuilder: (context, index) {
              singlehistory = tickethistory[index];
              MaterialColor a;
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
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
                            'TICKET ID: ${singlehistory!.ticketid}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: a = singlehistory!.status == "active"
                                  ? Colors.green
                                  : a = singlehistory!.status == "expired"
                                      ? Colors.red
                                      : Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Booked Time:' +
                          convertTo12HourFormat(singlehistory!.time) +
                          " - " +
                          convertTo12HourFormat(singlehistory!.time + 1)),
                      Text(
                          'Booked Date: ${singlehistory!.date.substring(0, 11)}'),
                      Text('Status: ${singlehistory!.status}'),
                      Text('Price: ${singlehistory!.price}'),
                    ],
                  ),
                ),
                onTap: () {
                  if (a == Colors.green) {
                    Routes.instance.push(
                        QR(
                          id: singlehistory!.id,
                          qrnumber: singlehistory!.ticketid.toString(),
                        ),
                        context);
                  } else if (a == Colors.red) {
                    showCustomDialog(
                        context: context,
                        content: "Ticket Expired",
                        buttonText: "OK",
                        navigateFrom: BookedTicketsScreen(),
                        title: "Warning");
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

////////////////////////////
  bool isDateTimeLaterThanNow(String dateString, int hour) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Get the current date and time
    DateTime now = DateTime.now();

    // Compare the date part
    if (dateTime.year > now.year ||
        (dateTime.year == now.year && dateTime.month > now.month) ||
        (dateTime.year == now.year &&
            dateTime.month == now.month &&
            dateTime.day > now.day)) {
      return true; // Date is later than now
    } else if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // Compare the time part if the date is the same
      if (hour > now.hour ||
          (hour == now.hour && dateTime.minute > now.minute)) {
        return true; // Time is later than now
      }
    }

    return false; // Date and time are not later than now
  }
}
