// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButton extends StatelessWidget {
  final String buttonText; 
  final VoidCallback onPressed; 

  
  const NextButton({
    super.key,
    required this.buttonText, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, 
      height: 70, 
      padding: const EdgeInsets.all(10.0), 
      decoration: BoxDecoration(
        color: const Color(0xFFFCD956), 
        borderRadius: BorderRadius.circular(20), 
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor:
              Colors.transparent, 
          elevation: 0, 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8), 
            Text(
              buttonText, 
              style: GoogleFonts.albertSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
