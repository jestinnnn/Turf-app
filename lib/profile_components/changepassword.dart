import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:turf_nest/home.dart';
import 'package:turf_nest/profile.dart';
import 'package:turf_nest/routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isChangingPassword = false;

  void _changePassword()async {
    // Implement your logic to change the password
   var a = await FirebaseAuthHelper.instance
                          .changePassword(newPasswordController.text);

                      if (a) {
                        showCustomDialog(
                            context: context,
                            content: "password changes sucessfully",
                            buttonText: "OK",
                            navigateFrom:HomeScreen(),
                            title: "NOTE");
                       
                      } else {
                        showCustomDialog(
                            context: context,
                            content: "Error changing password",
                            buttonText: "OK",
                            navigateFrom: HomeScreen(),
                            title: "ALERT");
                      
                      }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //double overlapHeight = screenHeight * 0.3;
    double middleHeight = screenHeight * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(children: [
        Positioned(
          width: screenWidth,
          height: 0.3 * screenHeight,
          child: Container(
            height: middleHeight,
            color: AppColors.blue,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: .05 * screenHeight),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isChangingPassword ? 0 : 1,
                child: Text(
                  "Change Password",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 0.05 * screenHeight,
                  ),
                ),
              ),
              SizedBox(height: .05 * screenHeight),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isChangingPassword ? 0 : 1,
                child: TextField(
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
                ),
              ),
              SizedBox(height: .01 * screenHeight),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isChangingPassword ? 0 : 1,
                child: TextField(
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
                ),
              ),
              SizedBox(height: 0.01 * screenHeight),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isChangingPassword ? 0 : 1,
                child: TextField(
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
                ),
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isChangingPassword
                    ? Center(
                        key: Key('loading'),
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ButtonStyles.lsButton(
                            buttonText: "Change Password"),
                        onPressed: () {
                          // Check if passwords match and change the password
                          if (newPasswordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Passwords do not match!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            _changePassword();
                          }
                        },
                        child: Text('Change Password'),
                      ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
