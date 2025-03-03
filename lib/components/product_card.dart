import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/user_fav_items.dart';

class ProductCard extends StatefulWidget {
  final Widget image;
  final String name;
  final double price;
  final VoidCallback onpressed;
  final int id;
  final String category;
  final String details;
  final String imagePath;
  final int userId;

  ProductCard({
    required this.id,
    required this.category,
    required this.details,
    required this.image,
    required this.name,
    required this.price,
    required this.onpressed,
    required this.imagePath,
    required this.userId,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late List<int> _userFavsId; // initialize it later
  late bool _isFav;

  bool _getIsFav() {
    _userFavsId = UserFavItems.getAllValuesByUserId(widget.userId);
    for (int i = 0; i < _userFavsId.length; i++) {
      if (_userFavsId[i] == widget.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _isFav = _getIsFav();
    return InkWell(
      onTap: widget.onpressed,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Başlığı sola yaslar
          children: [
            widget.image,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isFav = !_isFav;
                        });
                        if (!_isFav) {
                          UserFavItems.removeFavorite(widget.userId, widget.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Ürün favorilerden çıkarıldı."),
                              showCloseIcon: true,
                            ),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Ürün favorilere eklendi."),
                            showCloseIcon: true,
                          ),
                        );
                        UserFavItems.items.add({widget.userId: widget.id});
                      },
                      icon:
                          _isFav
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Text(
                  "\$${widget.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
