class CartModel {
  final int id;
  final String productName;
  final double price;
   int quantity;

  CartModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productName: json['product']['name'],
      price: double.parse(json['product']['price'].toString()),
      quantity: json['quantity'],
    );
  }
}
