// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/First%20Sector/loginbutton.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool isSellerSelected = true;

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
                    'Create Your Account', // Text below the logo
                    style: GoogleFonts.albertSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start a new way of grocery shopping with SEKO',
                    style: GoogleFonts.albertSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: Container(
              width: 300,
              height: 70,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFFFCD956),
                  width: 1.0,
                ),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    alignment: isSellerSelected
                        ? Alignment.centerLeft
                        : Alignment.centerRight, // Change based on selection
                    duration:
                        const Duration(milliseconds: 300), // Smooth animation
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 254, 254),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFCD956), // Border color
                          width: 3.0, // Border width (thin)
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector for "Seller"
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSellerSelected = true; // Set to seller
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Seller',
                            style: GoogleFonts.albertSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSellerSelected = false; // Set to buyer
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Buyer',
                            style: GoogleFonts.albertSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 50), // Additional space if needed

          // Text Fields for input
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(context, "Name"),
                const SizedBox(height: 10), // Space between fields
                _buildTextField(context, "Email"),
                const SizedBox(height: 10), // Space between fields
                _buildTextField(context, "Password"),
                const SizedBox(height: 10),
                _buildTextField(context, "Confirm Password"),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(height: 30), // Space before button
                const LoginButton(
                  buttonText: 'Next',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Text Field Builder
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
}
