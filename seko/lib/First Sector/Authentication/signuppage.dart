// ignore_for_file: deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:seko/enviroment.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController flat_no = TextEditingController();
  // TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // if (password.text != confirmPassword.text) {
    //   setState(() {
    //     isLoading = false;
    //     errorMessage = 'Passwords do not match';
    //   });
    //   return;
    // }

    final url = Uri.parse(
      '${Environment.baseUrl}/api/api/register/',
    ); // Replace with your backend URL

    final body = jsonEncode({
      'username': username.text.trim(),
      'email': email.text.trim(),
      'password': password.text,
      'flat_no': flat_no.text,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        // Registration successful
        Navigator.pushNamed(context, '/login');
      } else {
        // Handle error response
        final data = jsonDecode(response.body);
        setState(() {
          errorMessage = data.toString();
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error connecting to server';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget LoginButton(String buttonText) {
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
          registerUser();
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
                border: Border.all(color: const Color(0xFFFCD956), width: 1.0),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    alignment: isSellerSelected
                        ? Alignment.centerLeft
                        : Alignment.centerRight, // Change based on selection
                    duration: const Duration(
                      milliseconds: 300,
                    ), // Smooth animation
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
                _buildTextField(context, "Username", username),
                const SizedBox(height: 10),
                _buildTextField(context, "Email", email),
                const SizedBox(height: 10),
                _buildTextField(
                  context,
                  "Password",
                  password,
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                _buildTextField(context, "Flat_No", flat_no),

                // const SizedBox(height: 10),
                // _buildTextField(context, "Confirm Password"),
                const SizedBox(height: 100),
                const SizedBox(height: 30), // Space before button
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFFCD956,
                    ), // Your button color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                    textStyle: GoogleFonts.albertSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String hintText,
    TextEditingController controller, {
    bool obscureText = false,
  }) {
    return Container(
      width: 300,
      height: 70,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFCD956), width: 1.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
