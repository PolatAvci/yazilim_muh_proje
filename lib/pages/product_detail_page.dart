import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Models/cart_items.dart';
import 'package:yazilim_muh_proje/Models/comment.dart';
import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:yazilim_muh_proje/Services/comment_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/comment_box.dart';
import 'package:yazilim_muh_proje/pages/all_comment_page.dart';
import 'package:yazilim_muh_proje/pages/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String details;
  final String imagePath;
  final double price;
  bool _isFav = false;
  List<Comment> productComments = [];
  List<dynamic> userFavItem = [];

  ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.details,
    required this.imagePath,
    required this.price,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  _isFavItem() {
    for (var item in widget.userFavItem) {
      if (item["product"]["id"] == widget.id) {
        setState(() {
          widget._isFav = true;
        });
        return;
      }
    }
    widget._isFav = false;
  }

  Future<void> _getAllUserFavItems() async {
    final response = await http.get(
      Uri.parse(
        "https://localhost:7212/api/UserFavItem/${UserService.user!.id}",
      ),
    );
    if (response.statusCode == 200) {
      widget.userFavItem = json.decode(response.body);
    }
  }

  Future<void> _removeFav() async {
    final response = await http.delete(
      Uri.parse(
        "https://localhost:7212/api/UserFavItem/${UserService.user!.id}/${widget.id}",
      ),
    );
    _getAllUserFavItems();
  }

  Future<void> _addFav() async {
    final response = await http.post(
      Uri.parse("https://localhost:7212/api/UserFavItem"),
      headers: {
        'Content-Type':
            'application/json', // JSON formatında veri gönderildiğini belirt
      },
      body: json.encode({
        "userId": UserService.user!.id,
        "productId": widget.id,
      }),
    );
    _getAllUserFavItems();
  }

  @override
  void initState() {
    super.initState();
    if (UserService.user?.id != null) {
      _getAllUserFavItems().then((_) => _isFavItem());
    }
    CommentService.getComments(widget.id).then((value) {
      setState(() {
        widget.productComments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> favItems = [];
    for (var item in widget.userFavItem) {
      favItems.add(item["product"]["id"]);
    }
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
                if (favItems.contains(widget.id)) {
                  _removeFav();
                  widget._isFav = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ürün favorilerden çıkarıldı"),
                      showCloseIcon: true,
                    ),
                  );
                } else {
                  _addFav();
                  widget._isFav = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ürün favorilere eklendi"),
                      showCloseIcon: true,
                    ),
                  );
                }
              });
            },
            icon:
                widget._isFav
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
                    "Kategori: Sonra eklenecek",
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
                        onPressed: () {
                          if (CartItems.items.any(
                            (product) => product.id == widget.id,
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün sepetinizde zaten var"),
                              ),
                            );
                            return;
                          }
                          CartItems.items.add(
                            Product(
                              id: widget.id,
                              details: widget.details,
                              name: widget.name,
                              price: widget.price,
                              image: widget.imagePath,
                              productCategories: [], //ŞİMDİLİK BOŞ
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Ürün sepete eklendi")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400,
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
                        ),
                        child: Text(
                          "Hemen Satın Al",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Yorumlar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.productComments.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Bu ürüne henüz yorum yapılmamış.",
                                  ),
                                  showCloseIcon: true,
                                ),
                              );
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AllCommentPage(id: widget.id),
                              ),
                            );
                          },
                          child: Text(
                            "Tümünü gör",
                            style: TextStyle(color: Colors.blue.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.productComments.isEmpty
                      ? Text("Bu ürüne henüz yorum yapılmamış")
                      : SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.productComments.length >= 5
                                  ? 5
                                  : widget.productComments.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return CommentBox(
                              text: widget.productComments[i].text,
                              star: widget.productComments[i].star,
                              date: widget.productComments[i].date,
                            );
                          },
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
