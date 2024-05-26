import 'package:flutter/material.dart';
import 'package:turf_nest/profile_components/BookedTickets.dart';

import 'package:turf_nest/constants.dart';
import 'package:turf_nest/custom.dart';
import 'package:turf_nest/firebase_helper/firebase_auth_helper/auth_helper.dart';

import 'package:turf_nest/home.dart';
import 'package:turf_nest/login.dart';
import 'package:turf_nest/profile_components/Terms.dart';
import 'package:turf_nest/profile_components/changepassword.dart';
import 'package:turf_nest/profile_components/feedback.dart';
import 'phone_utils.dart'; // Import the phone_utils.dart file

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // double overlapHeight = screenHeight * 0.3;
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
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: Stack(
          children: [
            Positioned(
              width: screenWidth,
              height: 0.28 * screenHeight,
              child: Container(
                height: middleHeight,
                color: AppColors.blue,
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 0.05 * screenHeight,
                      ),
                    ),
                    SizedBox(height: .05 * screenHeight),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.0,
                        children: [
                          buildProfileButton(
                            icon: Icons.event,
                            label: 'Booked Tickets',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookedTicketsScreen(),
                                ),
                              );
                            },
                          ),
                          buildProfileButton(
                            icon: Icons.lock,
                            label: 'Change Password',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen()),
                              );
                            },
                          ),
                          buildProfileButton(
                              icon: Icons.feedback,
                              label: 'Feedback',
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeedbackScreen(),
                                  ),
                                );
                              }),
                          buildProfileButton(
                            icon: Icons.article,
                            label: 'Terms and Conditions',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsAndConditionsScreen()),
                              );
                            },
                          ),
                          buildProfileButton(
                            icon: Icons.emergency,
                            label: 'Emergency',
                            onPressed: () {
                              launchPhoneApp(
                                  '112'); // Call _launchPhoneApp function (not working)
                            },
                          ),
                          buildProfileButton(
                            icon: Icons.logout,
                            label: 'Logout',
                            onPressed: () async {
                              await FirebaseAuthHelper.instance.signout();
                              showCustomDialog(
                                  context: context,
                                  content: "Logging out from current aaccount",
                                  buttonText: "OK",
                                  navigateFrom: LoginScreen(),
                                  title: "log out");
                              // Example for calling police
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
