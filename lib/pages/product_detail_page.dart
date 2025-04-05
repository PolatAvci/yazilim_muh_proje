import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:yazilim_muh_proje/Models/cart_items.dart';
import 'package:yazilim_muh_proje/Models/comment.dart';
import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:yazilim_muh_proje/Services/comment_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/comment_box.dart';
import 'package:yazilim_muh_proje/pages/all_comment_page.dart';
import 'package:yazilim_muh_proje/pages/cart_page.dart';
import 'package:yazilim_muh_proje/pages/login_page.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String details;
  final String imagePath;
  final double price;

  const ProductDetailPage({
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
  bool _isFav = false;
  List<Comment> productComments = [];
  List<dynamic> userFavItem = [];

  _isFavItem() {
    for (var item in userFavItem) {
      if (item["product"]["id"] == widget.id) {
        setState(() {
          _isFav = true;
        });
        return;
      }
    }
    _isFav = false;
  }

  Future<void> _getAllUserFavItems() async {
    final response = await http.get(
      Uri.parse(
        "https://localhost:7212/api/UserFavItem/${UserService.user!.id}",
      ),
    );
    if (response.statusCode == 200) {
      userFavItem = json.decode(response.body);
    }
  }

  Future<void> _removeFav() async {
    await http.delete(
      Uri.parse(
        "https://localhost:7212/api/UserFavItem/${UserService.user!.id}/${widget.id}",
      ),
    );
    _getAllUserFavItems();
  }

  Future<void> _addFav() async {
    await http.post(
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
        productComments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> favItems = [];
    for (var item in userFavItem) {
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
              if (UserService.user?.id == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Lütfen giriş yapın"),
                    showCloseIcon: true,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                return;
              }
              setState(() {
                if (favItems.contains(widget.id)) {
                  _removeFav();
                  _isFav = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ürün favorilerden çıkarıldı"),
                      showCloseIcon: true,
                    ),
                  );
                } else {
                  _addFav();
                  _isFav = true;
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
                _isFav
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              if (UserService.user?.id == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Lütfen giriş yapın"),
                    showCloseIcon: true,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                return;
              }
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
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Yorumlar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              AllCommentPage(id: widget.id),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade600,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tüm Yorumları Gör",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  productComments.isNotEmpty
                      ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              productComments
                                  .take(4)
                                  .map(
                                    (comment) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 4),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors
                                                                    .yellow
                                                                    .shade700,
                                                          ),
                                                          Text(comment.text),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                'dd/MM/yyyy',
                                                              ).format(
                                                                comment.date,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      )
                      : Text(
                        "Henüz yorum yapılmadı.",
                        style: TextStyle(fontSize: 16),
                      ),

                  SizedBox(height: 8),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (UserService.user?.id == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Lütfen giriş yapın"),
                                showCloseIcon: true,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                            return;
                          }
                          if (CartItems.items.any(
                            (product) => product.id == widget.id,
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün sepetinizde zaten var"),
                                showCloseIcon: true,
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
                            SnackBar(
                              content: Text("Ürün sepete eklendi"),
                              showCloseIcon: true,
                            ),
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
                        onPressed: () {
                          if (UserService.user?.id == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Lütfen giriş yapın"),
                                showCloseIcon: true,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                            return;
                          }
                          if (CartItems.items.any(
                            (product) => product.id == widget.id,
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Ürün sepetinizde zaten var"),
                                showCloseIcon: true,
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
                            SnackBar(
                              content: Text("Ürün sepete eklendi"),
                              showCloseIcon: true,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
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
                            if (productComments.isEmpty) {
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
                  productComments.isEmpty
                      ? Text("Bu ürüne henüz yorum yapılmamış")
                      : SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productComments.length >= 5
                                  ? 5
                                  : productComments.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return CommentBox(
                              text: productComments[i].text,
                              star: productComments[i].star,
                              date: productComments[i].date,
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
