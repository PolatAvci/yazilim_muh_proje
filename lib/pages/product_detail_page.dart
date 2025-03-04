import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/user_fav_items.dart';
import 'package:yazilim_muh_proje/pages/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final int userId;
  final String name;
  final String category;
  final String details;
  final String imagePath;
  final double price;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.details,
    required this.imagePath,
    required this.price,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    List<int> favItems = UserFavItems.getAllValuesByUserId(widget.userId);
    for (int itemId in favItems) {
      if (itemId == widget.id) {
        _isFav = true;
        return;
      }
    }
    _isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    List<int> favItems = UserFavItems.getAllValuesByUserId(widget.userId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(widget.name, style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                for (int itemId in favItems) {
                  if (itemId == widget.id) {
                    UserFavItems.removeFavorite(widget.userId, widget.id);
                    _isFav = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ürün favorilerden çıkarıldı"),
                        showCloseIcon: true,
                      ),
                    );
                    return;
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Ürün favorilere eklendi"),
                    showCloseIcon: true,
                  ),
                );
                UserFavItems.items.add({widget.userId: widget.id});
                _isFav = true;
              });
            },
            icon:
                _isFav
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kategori: ${widget.category}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "₺${widget.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Ürün Açıklaması",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(widget.details, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Sepete Ekle",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Satın Al",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
