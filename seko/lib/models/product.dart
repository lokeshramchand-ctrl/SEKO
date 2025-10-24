// lib/models/product_model.dart
class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? 'Unnamed',
      image: json['image']?.toString() ?? '',
      price: _parseToDouble(json['price']),
      category: json['category']?.toString() ?? 'Unknown',
    );
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
