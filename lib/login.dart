import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:turf_nest/forgotpassword.dart';
import 'package:turf_nest/home.dart';
import 'package:turf_nest/routes.dart';
import 'package:turf_nest/signup.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                bool login = await FirebaseAuthHelper.instance.login(
                    emailController.text, passwordController.text, context);

                if (login) {
                  Routes.instance.push(HomeScreen(), context);
                }
              },
              style: ButtonStyles.lsButton(buttonText: "Login"),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Routes.instance.push(SignUpScreen(), context);
              },
              child: Text(
                "Create Account",
                style: TextStyle(color: AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
