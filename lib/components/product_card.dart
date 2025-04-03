import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    required this.userId,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Future<bool> _getIsFav() async {
    final response = await http.get(
      Uri.parse('https://localhost:7212/api/UserFavItem/${widget.userId}'),
    );
    if (response.statusCode == 200) {
      List<dynamic> favItems = json.decode(response.body);
      for (var item in favItems) {
        if (item['productId'] == widget.id) {
          return true;
        }
      }
      return false;
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  @override
  void initState() {
    super.initState();
    _getIsFav().then((value) {
      setState(() {
        widget.isFav = value;
      });
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
                        setState(() {
                          widget.isFav = !widget.isFav;
                        });

                        if (widget.isFav) {
                          // Favoriye ekle
                          final response = await http.post(
                            Uri.parse('https://localhost:7212/api/UserFavItem'),
                            headers: {
                              'Content-Type':
                                  'application/json', // JSON formatında gönderildiğini belirt
                            },
                            body: json.encode({
                              'userId': widget.userId,
                              'productId': widget.id,
                            }),
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
                          final response = await http.delete(
                            Uri.parse(
                              'https://localhost:7212/api/UserFavItem/${widget.userId}/${widget.id}',
                            ),
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
