import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_muh_proje/Models/items.dart';
import 'package:yazilim_muh_proje/components/cart_item.dart';
import 'package:yazilim_muh_proje/pages/payment_page.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var items = Items.cartItems;
  double get totalPrice {
    return Items.cartItems.fold(
      0.0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  // Shipping cost logic
  double get shippingCost {
    return totalPrice >= 250.0 ? 0.0 : 20.0; // Free shipping if total > 250 TL
  }

  Widget _buildCartItem(int index) {
    var item = items[index];
    return CartItem(
      itemName: item["name"],
      imagePath: item["image"],
      itemQuantity: item["quantity"],
      itemPrice: item["price"],
      onDelete: () {
        setState(() {
          Items.cartItems.removeAt(index);
        });
      },
      onDecrement: () {
        setState(() {
          if (item["quantity"] > 1) {
            item["quantity"]--;
          }
        });
      },
      onIncrement: () {
        setState(() {
          item["quantity"]++;
        });
      },
    );
  }

  // Function to show a confirmation dialog before proceeding to payment
  void _showPaymentConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Sepeti Onayla',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade400,
              ),
            ),
            content: Text(
              'Sepetinizi onaylıyor musunuz? Ödeme işlemine geçilecek.',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'Vazgeç',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PaymentPage(
                            items: items,
                            shippingCost: shippingCost,
                          ),
                    ),
                  );
                },
                child: Text(
                  'Onayla ve Öde',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.green),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'TRAKSTORE Sepetim',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, size: 28, color: Colors.white),
            onPressed: () {
              setState(() {
                Items.cartItems.clear();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child:
                  Items.cartItems.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_shopping_cart,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Sepetiniz boş",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: Items.cartItems.length,
                        itemBuilder: (context, index) {
                          return _buildCartItem(index);
                        },
                      ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Toplam: \$${totalPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kargo Ücreti: \$${shippingCost.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Toplam Tutar: \$${(totalPrice + shippingCost).toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Ödemeye Geç Butonu
                  ElevatedButton(
                    onPressed: _showPaymentConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Ödemeye Geç',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
