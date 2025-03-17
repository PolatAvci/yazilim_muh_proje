import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_muh_proje/Models/cart_items.dart';
import 'package:yazilim_muh_proje/Models/product.dart';

class CartItem extends StatefulWidget {
  final String imagePath;
  final String itemName;
  final double itemPrice;
  final int itemQuantity;
  final VoidCallback onDelete;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  final List<Product> cartItems = CartItems.items;

  CartItem({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
    required this.onDelete,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  double _getTotalPrice() {
    return widget.itemPrice * widget.itemQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shadowColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imagePath,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fiyat: \$${widget.itemPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    'Toplam: \$${_getTotalPrice().toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 28),
                  onPressed: widget.onDecrement,
                ),
                Text(
                  widget.itemQuantity.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade400,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                  onPressed: widget.onIncrement,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 26, color: Colors.red),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
