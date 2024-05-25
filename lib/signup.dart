import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:turf_nest/home.dart';

import 'package:turf_nest/routes.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  int currentStep = 0;

  void _validateEmail(BuildContext context) {
    // Implement your email validation logic here
    // For example, check if the email format is correct
    // If valid, proceed to the next step
    setState(() {
      currentStep++;
    });
  }

  void _validatePhone(BuildContext context) {
    // Implement your phone validation logic here
    // If valid, proceed to the next step

    setState(() {
      currentStep++;
    });
  }

  void _validateUsername(BuildContext context) {
    // Implement your username validation logic here
    // If valid, proceed to the next step

    setState(() {
      currentStep++;
    });
  }

  _signUp(BuildContext context) async {
    bool issignup = await FirebaseAuthHelper.instance.signup(
      context,
      nameController.text,
      emailController.text,
      phoneController.text,
      usernameController.text,
    );

    if (issignup) {
      Routes.instance.push(HomeScreen(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                currentStep == 0 ? 0 : -MediaQuery.of(context).size.width,
                0,
                0,
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                currentStep == 1 ? 0 : -MediaQuery.of(context).size.width,
                0,
                0,
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                currentStep == 2 ? 0 : -MediaQuery.of(context).size.width,
                0,
                0,
              ),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                currentStep == 3 ? 0 : -MediaQuery.of(context).size.width,
                0,
                0,
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (currentStep > 0) {
                      setState(() {
                        currentStep--;
                      });
                    }
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyles.lsButton(buttonText: "Next"),
                  onPressed: () async {
                    if (currentStep == 0) {
                      // Validate email
                      _validateEmail(context);
                    } else if (currentStep == 1) {
                      // Validate phone
                      _validatePhone(context);
                    } else if (currentStep == 2) {
                      // Validate username
                      _validateUsername(context);
                    } else if (currentStep == 3) {
                      // Sign up
                      bool issignup = await FirebaseAuthHelper.instance.signup(
                        context,
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        usernameController.text,
                      );

                      if (issignup) {
                        Routes.instance.push(HomeScreen(), context);
                      }
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
