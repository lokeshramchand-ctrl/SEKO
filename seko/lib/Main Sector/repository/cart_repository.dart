import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/cart.dart';

class CartService {
  final _baseUrl = 'http://<your-backend-domain>/cart/';
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<List<CartModel>> getCartItems() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CartModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch cart');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'product': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add to cart');
    }
  }

  Future<void> updateQuantity(int cartId, int quantity) async {
    final token = await _getToken();
    final response = await http.patch(
      Uri.parse('$_baseUrl$cartId/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  Future<void> removeItem(int cartId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl$cartId/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }
}
