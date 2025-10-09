// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/First%20Sector/loginbutton.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Padding for top space
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/3.png", // Replace with your logo image path
                    height: 100, // Set the height of the logo
                    fit: BoxFit.contain, // Adjust fit as needed
                  ),
                  const SizedBox(height: 20), // Space between logo and text
                  Text(
                    'Welcome to SEKO!', // Text below the logo
                    style: GoogleFonts.albertSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Customize color as needed
                    ),
                  ),
                  const SizedBox(height: 8), // Space between two text elements
                  Text(
                    'Farmer to Person', // Text below the logo
                    style: GoogleFonts.albertSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black, // Customize color as needed
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50), // Additional space if needed

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button Container with Icon
                _buildButton(
                  context,
                  "Sign Up with Google",
                  "assets/4.png", // Path to your custom Google icon
                  () {
                    // Add your sign-in action here
                  },
                ),
                const SizedBox(height: 10), // Space between buttons
                _buildButton(
                  context,
                  "Sign Up with Apple",
                  "assets/5.png", // Path to your custom Apple icon
                  () {
                    // Add your sign-in action here
                  },
                ),
                const SizedBox(height: 10), // Space between buttons
                _buildButton(
                  context,
                  "Sign Up with Facebook",
                  "assets/6.png", // Path to your custom Facebook icon
                  () {
                    // Add your sign-in action here
                  },
                ),
                const SizedBox(height: 10), // Space between buttons
                _buildButton(
                  context,
                  "Sign Up with Email",
                  "assets/7.png", // Path to your custom Email icon
                  () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: Text(
                  "OR",
                  style: GoogleFonts.albertSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                )),
                const SizedBox(height: 30), // Space between buttons
                const LoginButton(
                  buttonText: 'Login',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String iconPath,
      VoidCallback onPressed) {
    return Container(
      width: 300, // Fixed width for all buttons
      height: 70, // Fixed height for all buttons
      padding: const EdgeInsets.all(10.0), // Add padding around the button
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9), // Background color of the container
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 24), // Custom icon
            const SizedBox(width: 8), // Space between icon and text
            Text(
              text,
              style: GoogleFonts.albertSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Customize color as needed
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor:
              Colors.transparent, // Makes button background transparent
          elevation: 0, // Remove button shadow
        ),
      ),
    );
  }
}
