// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/First%20Sector/loginbutton.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

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
                  const SizedBox(height: 20), // Space between logo and text
                  Text(
                    'Forgot Password', // Text below the logo
                    style: GoogleFonts.albertSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Customize color as needed
                    ),
                  ),
                  const SizedBox(height: 8), // Space between two text elements
                  Text(
                    'It’s totally fine to forget password', // Text below the logo
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
          const SizedBox(
            height: 150,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(context, "Email"),
                const SizedBox(height: 30), // Space between fields
                const SizedBox(height: 100),
                const SizedBox(height: 150), // Space before button
                const LoginButton(
                  buttonText: 'Next',
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

Widget _buildTextField(BuildContext context, String hintText) {
  return Container(
    width: 300,
    height: 70,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFD9D9D9),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFFFCD956), // Border color
        width: 1.0, // Border width (thin)
      ),
    ),
    child: TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.albertSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.6),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
      style: GoogleFonts.albertSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
  );
}
