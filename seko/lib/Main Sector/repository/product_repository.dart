// lib/repository/product_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seko/enviroment.dart';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final url = Uri.parse(
      '${Environment.baseUrl}/api/products/?category=$category',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load $category products');
    }
  }
}
