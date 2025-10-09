// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/First%20Sector/Button2.dart';

class DateInputPage extends StatefulWidget {
  const DateInputPage({super.key});

  @override
  _DateInputPageState createState() => _DateInputPageState();
}

class _DateInputPageState extends State<DateInputPage> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1FF), // Background color

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Space between logo and text
            Text(
              'Information', // Text below the logo
              style: GoogleFonts.albertSans(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Customize color as needed
              ),
            ),
            const SizedBox(height: 8), // Space between two text elements
            Text(
              'Your Date of Birth defines what generation your are', // Text below the logo
              style: GoogleFonts.albertSans(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.black, // Customize color as needed
              ),
            ),

            const SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateInput("DD", _dayController),
                const SizedBox(width: 20),
                _buildDateInput("MM", _monthController),
                const SizedBox(width: 20),
                _buildDateInput("YYYY", _yearController),
              ],
            ),
            const SizedBox(height: 200),
             NextButton(buttonText: 'Next',                  onPressed: () {
                    Navigator.pushNamed(context, '/imagepicker');
                  },)
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Expanded(
      // Wrap the container with Expanded to give it a finite width
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFCD956),
            borderRadius: BorderRadius.circular(
                20)), // This sets the outer container color if needed
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.albertSans(color: Colors.black54),
            filled: true, // Ensures the background color is filled
            fillColor: const Color(
                0xFFFCD956), // Change this to the color you want for the background
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
