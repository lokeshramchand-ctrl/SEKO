// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/Last%20Sector/checkout.dart';
import 'package:seko/Main%20Sector/models/product.dart';
import '../enviroment.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  Color getRandomPastelColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(55),
      200 + random.nextInt(55),
      200 + random.nextInt(55),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
              decoration: BoxDecoration(
                color: getRandomPastelColor(),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: isSmallScreen ? 40 : 60),
                  Center(
                    child: Image.network(
                      product.image.startsWith('http')
                          ? product.image
                          : '${Environment.baseUrl}${product.image.startsWith('/images/') ? product.image : '/images/${product.image}'}',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 60 : 120),
                  Text(
                    product.name,
                    style: GoogleFonts.albertSans(
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 75),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.albertSans(
                      fontSize: isSmallScreen ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () {},
              child: Center(
                child: Text(
                  'Ask for Better Price',
                  style: GoogleFonts.albertSans(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFCD956),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: isSmallScreen
                  ? screenWidth * 0.8
                  : 300, // Responsive width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFCD956),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
                  Navigator.push(context, const CartPage() as Route<Object?>);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 23.0),
                  child: Text(
                    'Add To Cart',
                    style: GoogleFonts.albertSans(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
