// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final String buttonText; // Add buttonText as a parameter

  const LoginButton({
    super.key,
    required this.buttonText, // Make buttonText required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width for all buttons
      height: 70, // Fixed height for all buttons
      padding: const EdgeInsets.all(10.0), // Add padding around the button
      decoration: BoxDecoration(
        color: const Color(0xFFFCD956), // #FCD956 background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/homepage');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor:
              Colors.transparent, // Makes button background transparent
          elevation: 0, // Remove button shadow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8), // Space between icon and text
            Text(
              buttonText, // Use the parameter buttonText
              style: GoogleFonts.albertSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Customize color as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
