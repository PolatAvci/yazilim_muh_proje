import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Services/product_service.dart';

class FavoritePage extends StatefulWidget {
  final int userId;

  const FavoritePage({super.key, required this.userId});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<dynamic>? _favProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ProductService.getAllFav(widget.userId).then((value) {
      setState(() {
        _favProducts = value;
      });
      if (_favProducts == null) {
        throw Exception("Hata");
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorilerim",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator()) // Yükleme animasyonu
              : _favProducts!.isEmpty
              ? Center(
                child: Text(
                  "Henüz favori ürün eklemediniz",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: _favProducts!.length,
                itemBuilder: (context, i) {
                  var item = _favProducts![i]["product"];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.network(
                                item['image'] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      item['name'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$${item['price']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text(
                                            "${item['name']} favorilerden çıkarılsın mı?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "İptal",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                ProductService.removeFav(
                                                  widget.userId,
                                                  item["id"],
                                                ).then((_) {
                                                  ProductService.getAllFav(
                                                    widget.userId,
                                                  ).then((value) {
                                                    setState(() {
                                                      _favProducts = value;
                                                    });
                                                    if (_favProducts == null) {
                                                      throw Exception("Hata");
                                                    }
                                                    _isLoading = false;
                                                  });
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Onayla",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
