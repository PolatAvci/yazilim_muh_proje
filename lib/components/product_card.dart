import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/favorite_list.dart';
import 'package:yazilim_muh_proje/Models/product.dart';

class ProductCard extends StatefulWidget {
  final Widget image;
  final String name;
  final double price;
  final VoidCallback onpressed;
  final int id;
  final String category;
  final String details;
  final String imagePath;

  ProductCard({
    required this.id,
    required this.category,
    required this.details,
    required this.image,
    required this.name,
    required this.price,
    required this.onpressed,
    required this.imagePath,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _updateFavoriteStatus();
  }

  void _updateFavoriteStatus() {
    setState(() {
      _isFav = FavoriteList.items.any((item) => item.id == widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          if (_isFav) {
                            FavoriteList.items.removeWhere(
                              (item) => item.id == widget.id,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün favorilerden çıkarıldı."),
                                showCloseIcon: true,
                              ),
                            );
                          } else {
                            FavoriteList.items.add(
                              Product(
                                id: widget.id,
                                category: widget.category,
                                details: widget.details,
                                name: widget.name,
                                price: widget.price,
                                image: widget.imagePath,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün favorilere eklendi."),
                                showCloseIcon: true,
                              ),
                            );
                          }
                          _isFav = !_isFav; // Favori durumunu değiştir
                        });
                      },
                      icon: Icon(
                        _isFav
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: _isFav ? Colors.red : Colors.grey,
                      ),
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFavoriteStatus();
  }
}
