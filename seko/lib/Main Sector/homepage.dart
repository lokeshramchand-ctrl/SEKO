// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/Main%20Sector/pages/dairy.dart';
import 'package:seko/Main%20Sector/pages/fruits.dart';
import 'package:seko/Main%20Sector/pages/greenies.dart';
import 'package:seko/Main%20Sector/pages/vegetables.dart';

// Import your pages

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {
      "image": "assets/42.png",
      "label": "Vegetables",
      "color": "0xFF9430A1", // Original color
      "page": const Vegetables(),
    },
    {
      "image": "assets/27.png",
      "label": "Dairy",
      "color": "0xFF8DCBFF", // Original color
      "page": const Dairy(),
    },
    {
      "image": "assets/25.png",
      "label": "Greenies",
      "color": "0xFFC3EA21", // Original color
      "page": const Greenies(),
    },
    {
      "image": "assets/43.png",
      "label": "Fruits",
      "color": "0xFFD33218", // Original color
      "page": const Fruits(),
    },
  ];

  void _onItemPressed(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Icon(
            Icons.location_on,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          'Hyderabad, India',
          style: GoogleFonts.albertSans(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Text(
              'Good morning,',
              style: GoogleFonts.albertSans(),
            ),
            const SizedBox(height: 4),
            Text(
              "Let's order fresh items for you",
              style: GoogleFonts.albertSans(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              "Fresh Items",
              style: GoogleFonts.albertSans(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio:
                      0.8, // Adjusts the aspect ratio of each item
                  crossAxisSpacing: 12.0, // Spacing between columns
                  mainAxisSpacing: 12.0, // Spacing between rows
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onItemPressed(items[index]
                        ["page"]), // Navigate to the respective page
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(int.parse(items[index]["color"]!))
                            .withOpacity(0.5), // Set opacity here
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Image.asset(
                              items[index]["image"]!,
                              height: 64,
                            ),
                          ),
                          Text(
                            items[index]["label"]!,
                            style: GoogleFonts.albertSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
