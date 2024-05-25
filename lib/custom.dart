import 'package:flutter/material.dart';
import 'package:turf_nest/constants.dart';

Widget buildProfileButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
      gradient: LinearGradient(
        colors: [
          AppColors.gradientStartColor,
          AppColors.gradientEndColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed, // Use the provided onPressed callback
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.blue, // Set icon color to white for contrast
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue, // Set text color to white for contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
