// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seko/First%20Sector/Button2.dart';

class DocumentPage extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Documents', // Text below the logo
              style: GoogleFonts.albertSans(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Customize color as needed
              ),
            ),
            const SizedBox(height: 8), // Space between two text elements
            Text(
              'These are very important', // Text below the logo
              style: GoogleFonts.albertSans(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.black, // Customize color as needed
              ),
            ),

            const SizedBox(height: 100),
            // Document Title
            Text(
              'Aadhaar Card',
              style: GoogleFonts.albertSans(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            // Drag and Drop Area with Image Display
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, size: 50),
                          Text('Drag and Drop'),
                        ],
                      )
                    : Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 50),
            NextButton(
              buttonText: 'Next',
              onPressed: () {
                Navigator.pushNamed(context, '/dateofbirth');
              },
            )
          ],
        ),
      ),
    );
  }
}
