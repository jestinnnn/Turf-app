import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:turf_nest/home.dart';
import 'package:turf_nest/profile.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isChangingPassword = false;

  void _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isChangingPassword = true;
      });

      var success = await FirebaseAuthHelper.instance.changePassword(newPasswordController.text);

      setState(() {
        isChangingPassword = false;
      });

      if (success) {
        showCustomDialog(
          context: context,
          content: "Password changed successfully",
          buttonText: "OK",
          navigateFrom: const HomeScreen(),
          title: "NOTE",
        );
      } else {
        showCustomDialog(
          context: context,
          content: "Error changing password",
          buttonText: "OK",
          navigateFrom: const HomeScreen(),
          title: "ALERT",
        );
      }
    }
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            width: screenWidth,
            height: 0.3 * screenHeight,
            child: Container(
              height: middleHeight,
              color: AppColors.blue,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.05 * screenHeight),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isChangingPassword ? 0 : 1,
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 0.05 * screenHeight,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.05 * screenHeight),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isChangingPassword ? 0 : 1,
                      child: TextFormField(
                        enabled: !isChangingPassword,
                        controller: currentPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 0.01 * screenHeight),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isChangingPassword ? 0 : 1,
                      child: TextFormField(
                        enabled: !isChangingPassword,
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 0.01 * screenHeight),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isChangingPassword ? 0 : 1,
                      child: TextFormField(
                        enabled: !isChangingPassword,
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isChangingPassword
                          ? const Center(
                              key: Key('loading'),
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ButtonStyles.lsButton(buttonText: "Change Password"),
                              onPressed: _changePassword,
                              child: const Text('Change Password'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
