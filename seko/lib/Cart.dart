// ignore_for_file: use_super_parameters, file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  /// =============================
  /// 🛒 CART STATE
  /// =============================
  List<CartItem> cartItems = [];

  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    // You can later replace this with a call from backend or local storage
    cartItems = [
      CartItem(
        id: 1,
        name: 'Orange',
        weight: '100 gm',
        price: 100.00,
        quantity: 1,
        image: 'assets/orange.png',
      ),
      CartItem(
        id: 2,
        name: 'Cabbage',
        weight: '500 gm',
        price: 40.00,
        quantity: 2,
        image: 'assets/cabbage.png',
      ),
      CartItem(
        id: 3,
        name: 'Strawberry',
        weight: '250 gm',
        price: 150.00,
        quantity: 1,
        image: 'assets/strawberry.png',
      ),
    ];
  }

  /// =============================
  /// 💡 CART LOGIC
  /// =============================

  void _toggleSelectAll() {
    setState(() => selectAll = !selectAll);
  }

  void _updateQuantity(int id, int newQuantity) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.id == id);
      if (index != -1) cartItems[index].quantity = newQuantity;
    });
  }

  void _removeItem(int id) {
    setState(() => cartItems.removeWhere((item) => item.id == id));
  }

  double _calculateTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _checkout() {
    // TODO: integrate with your backend / API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checkout Successful! (Total ₹${_calculateTotal().toStringAsFixed(2)})'),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// =============================
  /// 🧱 UI
  /// =============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.albertSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // 🧭 Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cartItems.length} Items',
                  style: GoogleFonts.albertSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: _toggleSelectAll,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: selectAll ? Colors.orange : Colors.white,
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: selectAll
                            ? const Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Select all',
                        style: GoogleFonts.albertSans(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🧺 Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(
                  item: item,
                  onQuantityChanged: (newQuantity) =>
                      _updateQuantity(item.id, newQuantity),
                  onDelete: () => _removeItem(item.id),
                );
              },
            ),
          ),

          // 💰 Total Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.albertSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '₹${_calculateTotal().toStringAsFixed(2)}',
                      style: GoogleFonts.albertSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _checkout,
                    child: Text(
                      'Checkout',
                      style: GoogleFonts.albertSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================
/// 📦 CART ITEM MODEL + WIDGET
/// =======================================

class CartItem {
  final int id;
  final String name;
  final String weight;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.quantity,
    required this.image,
  });

  double get total => price * quantity;
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onQuantityChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.fastfood, size: 40, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.albertSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.orange, size: 22),
                      onPressed: onDelete,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.weight,
                  style: GoogleFonts.albertSans(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                // Price + Quantity Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.albertSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (item.quantity > 1) {
                              onQuantityChanged(item.quantity - 1);
                            }
                          },
                          child: _buildQtyButton(Icons.remove, Colors.grey[200]!),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${item.quantity}',
                          style: GoogleFonts.albertSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => onQuantityChanged(item.quantity + 1),
                          child: _buildQtyButton(Icons.add, Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}
