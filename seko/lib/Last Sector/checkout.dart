// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = [
      {
        'name': 'Garlic',
        'price': 22.5,
        'quantity': 2,
        'image': "assets/21.png", // Replaced icon with asset image
      },
      {
        'name': 'Capsicum',
        'price': 55.0,
        'quantity': 1,
        'image': "assets/44.png", // Replaced icon with asset image
      },
      {
        'name': 'Cabbage',
        'price': 9.5,
        'quantity': 6,
        'image': "assets/13.png", // Replaced icon with asset image
      },
    ];

    // Static values for subtotal, taxes, management fee, and total
    double subtotal = 160.0;
    double taxes = 15.0;
    double managementFee = 2.5;
    double total = 177.5;

    return Scaffold(
      backgroundColor: const Color(0xFFFCD956),
      body: Column(
        children: [
          const SizedBox(height: 55),
          Container(
            width: 150, // Define width
            height: 50, // Define height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35), // Round corners
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child: Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Back",
                    style: GoogleFonts.albertSans(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height *
                  0.7, // Increased height for better layout
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invoice',
                        style: GoogleFonts.albertSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/3.png',
                        width: 64,
                        height: 64,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Products',
                    style: GoogleFonts.albertSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Items List
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  item['image'] is String
                                      ? Image.asset(
                                          item['image'] as String,
                                          width: 24,
                                          height: 24,
                                        )
                                      : Container(), // Fallback if image is not available
                                  const SizedBox(width: 8),
                                  Text(
                                    item['name'] as String,
                                    style: GoogleFonts.albertSans(),
                                  ),
                                ],
                              ),
                              Text(
                                '₹${(item['price'] as double).toStringAsFixed(2)}',
                                style: GoogleFonts.albertSans(),
                              ),
                              Text(
                                '${item['quantity']}',
                                style: GoogleFonts.albertSans(),
                              ),
                              Text(
                                '₹${((item['price'] as double) * (item['quantity'] as int).toDouble()).toStringAsFixed(2)}',
                                style: GoogleFonts.albertSans(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  // Summary Section (Subtotal, Taxes, Management Fee)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSummaryRow(
                            'All', '₹${subtotal.toStringAsFixed(2)}'),
                        _buildSummaryRow(
                            'Taxes', '₹${taxes.toStringAsFixed(2)}'),
                        _buildSummaryRow('Management',
                            '₹${managementFee.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Total Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.albertSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: GoogleFonts.albertSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle checkout action here
                  Navigator.pushNamed(context, '/payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '  Proceed to Payment  ',
                  style: GoogleFonts.albertSans(
                    color: const Color(0xFFFCD956),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.albertSans(),
          ),
          Text(
            amount,
            style: GoogleFonts.albertSans(),
          ),
        ],
      ),
    );
  }
}
