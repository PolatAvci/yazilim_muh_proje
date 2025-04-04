import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Services/Product_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';

class ProductCard extends StatefulWidget {
  final Widget image;
  final String name;
  final double price;
  final VoidCallback onpressed;
  final int id;
  final String category;
  final String details;
  final String imagePath;
  bool isFav = false;

  ProductCard({
    super.key,
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
  @override
  void initState() {
    super.initState();
    if (UserService.user?.id != null) {
      ProductService.getIsFav(UserService.user!.id, widget.id).then((value) {
        setState(() {
          widget.isFav = value;
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (UserService.user?.id != null) {
      ProductService.getIsFav(UserService.user.id, widget.id).then((value) {
        setState(() {
          widget.isFav = value;
        });
      });
    }
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
                    Flexible(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (UserService.user?.id == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Lütfen giriş yapınız!"),
                              showCloseIcon: true,
                            ),
                          );
                          return;
                        }
                        setState(() {
                          widget.isFav = !widget.isFav;
                        });

                        if (widget.isFav) {
                          // Favoriye ekle
                          final response = await ProductService.addFav(
                            UserService.user.id,
                            widget.id,
                          );

                          if (response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün favorilere eklendi."),
                                showCloseIcon: true,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Favoriye eklenirken bir hata oluştu.",
                                ),
                                showCloseIcon: true,
                              ),
                            );
                          }
                        } else {
                          // Favorilerden çıkar
                          final response = await ProductService.removeFav(
                            UserService.user.id,
                            widget.id,
                          );

                          if (response.statusCode == 204) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün favorilerden çıkarıldı."),
                                showCloseIcon: true,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Favorilerden çıkarılırken bir hata oluştu.",
                                ),
                                showCloseIcon: true,
                              ),
                            );
                          }
                        }
                      },
                      icon: Icon(
                        widget.isFav
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: widget.isFav ? Colors.red : Colors.grey,
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
}
