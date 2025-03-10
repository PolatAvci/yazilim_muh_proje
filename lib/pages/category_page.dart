import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/category_items.dart';
import 'package:yazilim_muh_proje/pages/category_products_page.dart';

class CategoryPage extends StatefulWidget {
  final int userId;
  const CategoryPage({super.key, required this.userId});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Kategoriler', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        itemCount: CategoryItems.items.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
        ),
        itemBuilder:
            (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CategoryProductsPage(
                          userId: widget.userId,
                          category: CategoryItems.items[index].name,
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Resmin de köşelerinin yuvarlak olması için
                      child: Image.asset(
                        CategoryItems.items[index].image,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400, // Arka plan rengi
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        CategoryItems.items[index].name,
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
    );
  }
}
