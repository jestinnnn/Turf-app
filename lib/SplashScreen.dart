import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turf_nest/constants.dart';

import 'package:turf_nest/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust animation duration as needed
    );

    // Create a curved animation for smoother transition
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start animation
    _animationController.forward();

    // Add a listener to navigate after animation completes
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkLoginStatus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose animation controller
    super.dispose();
  }

  void checkLoginStatus() async {
    // considering user is already logged in
    bool isLoggedIn = await Future.delayed(Duration(seconds: 3), () => true);

    // Navigate based on login status
    if (isLoggedIn) {
      navigateToHome();
    } else {
      navigateToLogin();
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            color: AppColors.white, // Background color
            child: Center(
              child: Text(
                'Turf Nest'.substring(
                    0,
                    (_animation.value * 'Turf Nest'.length)
                        .round()), // Animate text letter by letter
                style: GoogleFonts.caesarDressing(
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue, // Text color
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
