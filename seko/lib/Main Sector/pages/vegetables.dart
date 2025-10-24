// lib/pages/vegetables_page.dart
// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/Main%20Sector/ProductDetailPage.dart';
import 'package:seko/models/product.dart';
import 'package:seko/enviroment.dart';
import '../repository/product_repository.dart';

class Vegetables extends StatefulWidget {
  const Vegetables({super.key});

  @override
  State<Vegetables> createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  final ProductRepository _repository = ProductRepository();

  Future<List<Product>>? _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _repository.fetchProductsByCategory("Vegetables");
  }

  Color getRandomPastelColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      180 + random.nextInt(55),
      180 + random.nextInt(55),
      180 + random.nextInt(55),
    );
  }

  Widget buildItem(Product product, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: getRandomPastelColor(),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.025),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                product.image.startsWith('http')
                    ? product.image
                    : '${Environment.baseUrl}${product.image.startsWith('/images/') ? product.image : '/images/${product.image}'}',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 80,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                product.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.albertSans(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.albertSans(
                  fontSize: screenWidth * 0.035,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    Text(
                      'Vegetables',
                      style: GoogleFonts.albertSans(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/cartpage'),
                      icon: Image.asset(
                        'assets/51.png',
                        height: screenWidth * 0.12,
                        width: screenWidth * 0.12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Fresh Items",
                  style: GoogleFonts.albertSans(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 24),

                //Fetching from another side 
                FutureBuilder<List<Product>>(
                  future: _futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }

                    final items = snapshot.data!;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: screenWidth * 0.04,
                        mainAxisSpacing: screenWidth * 0.04,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return buildItem(
                          items[index],
                          screenWidth,
                          screenHeight,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
