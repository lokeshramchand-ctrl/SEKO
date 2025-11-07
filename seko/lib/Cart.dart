// ignore_for_file: use_super_parameters, file_names, deprecated_member_use, use_build_con, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seko/Main%20Sector/cartwidget.dart';
import 'package:seko/Main%20Sector/repository/cart_repository.dart';
import 'package:seko/models/cart.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);




  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  List<CartModel> cartItems = [];
  bool loading = true;
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      final items = await _cartService.getCartItems();
      setState(() {
        cartItems = items;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load cart: $e')),
      );
    }
  }

  void _toggleSelectAll() {
    setState(() => selectAll = !selectAll);
  }

  Future<void> _updateQuantity(int id, int newQuantity) async {
    setState(() {
      final index = cartItems.indexWhere((item) => item.id == id);
      if (index != -1) cartItems[index].quantity = newQuantity;
    });
    await _cartService.updateQuantity(id, newQuantity);
  }

  Future<void> _removeItem(int id) async {
    setState(() => cartItems.removeWhere((item) => item.id == id));
    await _cartService.removeItem(id);
  }

  double _calculateTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> _checkout() async {
    try {
      await _cartService.checkout();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Checkout Successful! Total ₹${_calculateTotal().toStringAsFixed(2)}'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => cartItems.clear());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checkout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.orange)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: GoogleFonts.albertSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${cartItems.length} Items',
                    style: GoogleFonts.albertSans(fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: _toggleSelectAll,
                  child: Row(children: [
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
                    Text('Select all',
                        style: GoogleFonts.albertSans(
                            color: Colors.orange, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ],
            ),
          ),

          // Items
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartModelWidget(
                  item: item,
                  onQuantityChanged: (q) => _updateQuantity(item.id, q),
                  onDelete: () => _removeItem(item.id),
                );
              },
            ),
          ),

          // Total Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: GoogleFonts.albertSans(fontWeight: FontWeight.w600)),
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
                    onPressed: _checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Checkout',
                        style: GoogleFonts.albertSans(
                            fontSize: 18, color: Colors.white)),
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
