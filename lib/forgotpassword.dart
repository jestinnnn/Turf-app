import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  int currentStep = 0;

  void _sendOTP(BuildContext context) {
    // Implement your logic to send OTP to the provided mobile number

    setState(() {
      currentStep++;
    });
  }

  void _verifyOTP(BuildContext context) {
    // Implement your logic to verify the entered OTP

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
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
              "Forgot Password?",
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
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
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
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
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
                      setState(
                        () {
                          currentStep--;
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyles.lsButton(buttonText: "Send OTP"),
                  onPressed: () {
                    if (currentStep == 0) {
                      // Send OTP
                      _sendOTP(context);
                    } else if (currentStep == 1) {
                      // Verify OTP
                      _verifyOTP(context);
                    }
                  },
                  child: Text(currentStep == 0 ? 'Send OTP' : 'Verify OTP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
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
              "Reset Password",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyles.lsButton(buttonText: "Reset Password"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                // Implement your logic to reset the password
              },
              child: const Text('Reset '),
            ),
          ],
        ),
      ),
    );
  }
}
