// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/Main%20Sector/pages/fruits.dart';
import 'package:seko/Main%20Sector/ProductDetailPage.dart';

class Vegetables extends StatefulWidget {
  const Vegetables({super.key});

  @override
  State<Vegetables> createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  final List<Map<String, dynamic>> items = [
    {
      "image": "assets/44.png",
      "label": "Capsicum",
      "color": "0xFFD33218",
      "shape": "circle",
      "sizeMultiplier": 1.2,
      "price": 2.50, // Use double for price
    },
    {
      "image": "assets/9.png",
      "label": "Beetroot",
      "color": "0xFF9430A1",
      "shape": "circle",
      "sizeMultiplier": 1.0,
      "price": 1.80, // Use double for price
    },
    {
      "image": "assets/18.png",
      "label": "Coconut",
      "color": "0xFFB4D887",
      "shape": "circle",
      "sizeMultiplier": 1.1,
      "price": 3.00, // Use double for price
    },
    {
      "image": "assets/21.png",
      "label": "Garlic",
      "color": "0xFF4CAF50",
      "shape": "rounded",
      "sizeMultiplier": 0.9,
      "price": 1.20, // Use double for price
    },
    {
      "image": "assets/36.png",
      "label": "Potato",
      "color": "0xFFD7B25D",
      "page": const Fruits(),
      "shape": "diagonal",
      "sizeMultiplier": 1.3,
      "price": 1.00, // Use double for price
    },
    {
      "image": "assets/40.png",
      "label": "Tomato",
      "color": "0xFFEC4C3D",
      "page": const Fruits(),
      "shape": "circle",
      "sizeMultiplier": 1.2,
      "price": 2.00, // Use double for price
    },
    {
      "image": "assets/46.png",
      "label": "Bell Pepper",
      "color": "0xFF6F9D8A",
      "page": const Fruits(),
      "shape": "rounded",
      "sizeMultiplier": 1.0,
      "price": 2.50, // Use double for price
    },
    {
      "image": "assets/45.png",
      "label": "Cucumber",
      "color": "0xFF72D5A6",
      "page": const Fruits(),
      "shape": "circle",
      "sizeMultiplier": 1.2,
      "price": 1.50, // Use double for price
    },
    {
      "image": "assets/33.png",
      "label": "Green Chilli",
      "color": "0xFF8C7B50",
      "page": const Fruits(),
      "shape": "rounded",
      "sizeMultiplier": 0.8,
      "price": 1.00, // Use double for price
    },
    {
      "image": "assets/29.png",
      "label": "Onion",
      "color": "0xFFFF2B2B",
      "page": const Fruits(),
      "shape": "circle",
      "sizeMultiplier": 1.1,
      "price": 0.80, // Use double for price
    },
    {
      "image": "assets/13.png",
      "label": "Cabbage",
      "color": "0xFFF6A100",
      "page": const Fruits(),
      "shape": "rounded",
      "sizeMultiplier": 1.3,
      "price": 1.50, // Use double for price
    },
  ];

  void _onItemPressed(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          image: item['image'],
          label: item['label'],
          price: item['price'],
          color: Color(int.parse(item['color'])),
        ),
      ),
    );
  }

  Widget buildItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _onItemPressed(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(int.parse(item["color"]!)).withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset(
                item["image"]!,
                height: 100,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item["label"]!,
              style: GoogleFonts.albertSans(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '₹${item["price"].toStringAsFixed(2)}', // Format price with dollar sign
              style: GoogleFonts.albertSans(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              Row(
                children: [
                  Text(
                    'Vegetables',
                    style: GoogleFonts.albertSans(fontSize: 24),
                  ),
                  const SizedBox(width: 190),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      icon: Image.asset(
                        'assets/51.png',
                        height: 48,
                        width: 48,
                      ))
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Fresh Items",
                style: GoogleFonts.albertSans(fontSize: 20),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 24),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return buildItem(items[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
