import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/profile.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.blue,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '1. Booking Terms:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'a. All bookings are subject to availability.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'b. Bookings can be made online or through the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. Usage Terms:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'a. Users must follow the turf guidelines and rules during their booking period.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'b. Misuse of the turf facilities may result in penalties or bans.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '3. Liability Disclaimer:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'a. The turf management holds no responsibility for injuries or damages during usage.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'b. Users are advised to use the facilities responsibly and at their own risk.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
