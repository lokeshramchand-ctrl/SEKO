// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:seko/Main%20Sector/ProductDetailPage.dart';
import 'package:seko/enviroment.dart';

class Vegetables extends StatefulWidget {
  const Vegetables({super.key});

  @override
  State<Vegetables> createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  Future<List<dynamic>> fetchVegetableProducts() async {
    final response = await http.get(
      Uri.parse('${Environment.baseUrl}/api/products/?category=Dairy'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dairy products');
    }
  }

  void _onItemPressed(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          image: item['image'],
          name: item['name'],
          price: item['price'],
          category: item['category'],
        ),
      ),
    );
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

  Widget buildItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _onItemPressed(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: getRandomPastelColor(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.network(
                '${Environment.baseUrl}${item["image"]}',
                height: 100,
              ),
            ),
            const SizedBox(height: 8),
            Text(item["name"]!, style: GoogleFonts.albertSans(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              '₹${(item["price"] is num ? item["price"] : double.tryParse(item["price"].toString()) ?? 0).toStringAsFixed(2)}',
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Image.asset('assets/51.png', height: 48, width: 48),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text("Fresh Items", style: GoogleFonts.albertSans(fontSize: 20)),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 24),

              // ✅ Use FutureBuilder instead of static list
              FutureBuilder<List<dynamic>>(
                future: fetchVegetableProducts(),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return buildItem(items[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
