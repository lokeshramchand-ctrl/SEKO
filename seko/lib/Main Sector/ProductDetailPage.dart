// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:seko/enviroment.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final double price;
  final String image;
  final String category;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });

  factory ProductDetailPage.fromJson(Map<String, dynamic> json) {
    return ProductDetailPage(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
    );
  }

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.price;
  }

  Future<List<ProductDetailPage>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('{$Environment.baseUrl}/api/products/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ProductDetailPage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Color getRandomPastelColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(55), // keeps values in lighter range
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
                      widget.image,
                      height: screenHeight * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 60 : 120),
                  Text(
                    widget.name,
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
                    '₹${_totalPrice.toStringAsFixed(2)}',
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
                  /*await DatabaseHelper.instance.insertItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.label} added to cart')),
                  );
                  */
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
