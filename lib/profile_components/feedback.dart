
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:turf_nest/home.dart';
import 'package:turf_nest/profile.dart';
import 'package:turf_nest/routes.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();

  FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.blue,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'We value your feedback!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyles.lsButton(buttonText: "submit Feedback"),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final String? email = prefs.getString('email');
                // Implement feedback submission logic here
                if (feedbackController.text.isNotEmpty) {
                  String? phone =
                      await FirebaseFirestoreHelper.instance.getPhoneById();
                  await FirebaseFirestoreHelper.instance
                      .feedback(feedbackController.text, phone!, email!);

                  // Placeholder for feedback submission
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Feedback Submitted'),
                      content: Text('Thank you for your feedback!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Routes.instance.push(HomeScreen(), context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your feedback'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text("submit Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}
