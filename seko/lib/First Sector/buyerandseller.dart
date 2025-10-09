// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/First%20Sector/b&sbutton.dart';
import 'package:seko/First%20Sector/Button2.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                    'Login', // Text below the logo
                    style: GoogleFonts.albertSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Customize color as needed
                    ),
                  ),
                  const SizedBox(height: 8), // Space between two text elements
                  Text(
                    'Welcome Back!', // Text below the logo
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
                Row(children: [
                  const SizedBox(width: 30),
                  ProfileButton(buttonText: 'Seller', onPressed: () {}),
                  const SizedBox(width: 50), // Space between fields
                  ProfileButton(buttonText: 'Buyer', onPressed: () {}),
                ]),

                const SizedBox(
                  height: 100,
                ),
                const SizedBox(height: 150), // Space before button
                NextButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.pushNamed(context, '/dateofbirth');
                  },
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
