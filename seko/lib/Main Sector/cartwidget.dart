import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/cart.dart';

class CartModelWidget extends StatelessWidget {
  final CartModel item;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

  const CartModelWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag, color: Colors.orange),
        title: Text(item.productName,
            style: GoogleFonts.albertSans(fontWeight: FontWeight.w600)),
        subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (item.quantity > 1) {
                  onQuantityChanged(item.quantity - 1);
                }
              },
            ),
            Text(item.quantity.toString(),
                style: GoogleFonts.albertSans(fontWeight: FontWeight.w500)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => onQuantityChanged(item.quantity + 1),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
