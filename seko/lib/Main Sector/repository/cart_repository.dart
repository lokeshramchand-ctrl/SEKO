import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seko/enviroment.dart';
import '../../models/cart.dart';

class CartService {
  final _storage = const FlutterSecureStorage();

  /// ✅ Construct base URL dynamically
  String get _baseUrl => '${Environment.baseUrl}/cart/';

  /// ✅ Retrieve JWT Token
  Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  /// 🛒 Fetch all items in the cart
  Future<List<CartModel>> getCartItems() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CartModel.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to fetch cart: ${response.statusCode}');
    }
  }

  /// ➕ Add a new item to the cart
  Future<void> addToCart(int productId, int quantity) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'product': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('❌ Failed to add to cart: ${response.statusCode}');
    }
  }

  /// 🔄 Update item quantity
  Future<void> updateQuantity(int cartId, int quantity) async {
    final token = await _getToken();
    final response = await http.patch(
      Uri.parse('$_baseUrl$cartId/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('❌ Failed to update cart item: ${response.statusCode}');
    }
  }

  /// ❌ Remove an item from the cart
  Future<void> removeItem(int cartId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl$cartId/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('❌ Failed to delete item: ${response.statusCode}');
    }
  }

  /// 💳 Checkout the cart
  Future<void> checkout() async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('${_baseUrl}checkout/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('❌ Checkout failed: ${response.statusCode}');
    }
  }
}
