import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:yazilim_muh_proje/Models/product_items.dart';
import 'package:yazilim_muh_proje/pages/product_detail_page.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;
  final int userId;

  const CategoryProductsPage({
    super.key,
    required this.category,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductItems.items;
    List<Product> categoryProducts = [];
    for (var product in products) {
      if (product.category.toLowerCase() == category.toLowerCase()) {
        categoryProducts.add(product);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body:
          categoryProducts.isEmpty
              ? Center(
                child: Text(
                  "Bu kategoride ürün bulunmamaktadır",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
              : GridView.builder(
                itemCount: categoryProducts.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Sadece Card içinde borderRadius
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ProductDetailPage(
                                      id: categoryProducts[index].id,
                                      userId: userId,
                                      name: categoryProducts[index].name,
                                      category:
                                          categoryProducts[index].category,
                                      details: categoryProducts[index].details,
                                      imagePath: categoryProducts[index].image,
                                      price: categoryProducts[index].price,
                                    ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ), // Resmin de köşelerinin yuvarlak olması için
                                child: Image.asset(
                                  categoryProducts[index].image,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.blue.shade400, // Arka plan rengi
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  categoryProducts[index].name,
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
                    ),
              ),
    );
  }
}
