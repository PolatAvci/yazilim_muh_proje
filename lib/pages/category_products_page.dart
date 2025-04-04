import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yazilim_muh_proje/pages/product_detail_page.dart';

class CategoryProductsPage extends StatefulWidget {
  final int category;
  final int userId;
  bool isLoading = true;

  CategoryProductsPage({
    super.key,
    required this.category,
    required this.userId,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  List<dynamic> _products = [];
  String categoryname = "";

  @override
  void initState() {
    super.initState();
    getCategoryName();
    fetchCategoryProducts();
  }

  Future<void> getCategoryName() async {
    final response = await http.get(
      Uri.parse('https://localhost:7212/api/Category/${widget.category}'),
    );
    if (response.statusCode == 200) {
      categoryname = json.decode(response.body)["name"];
    }
  }

  Future<void> fetchCategoryProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://localhost:7212/api/ProductCategory/${widget.category}',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _products = data;
          widget.isLoading = false;
        });
      } else {
        setState(() {
          widget.isLoading = false;
        });
      }
    } catch (e) {
      print("Hata: $e");
      setState(() {
        widget.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryname, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body:
          widget.isLoading
              ? Center(child: CircularProgressIndicator()) // Yükleme animasyonu
              : _products.isEmpty
              ? Center(
                child: Text(
                  "Bu kategoride ürün bulunmamaktadır",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
              : GridView.builder(
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  var product = _products[index]["product"];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetailPage(
                                    id: product['id'],
                                    name: product['name'],
                                    details: product['details'],
                                    imagePath: product['image'],
                                    price: product['price'],
                                  ),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product['image'] ?? '',
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                product['name'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
