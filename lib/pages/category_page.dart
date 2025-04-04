import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'dart:convert';
import 'package:yazilim_muh_proje/pages/category_products_page.dart';

class CategoryPage extends StatefulWidget {
  bool isLoading = true;
  CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7212/api/Category'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _categories = List<Map<String, dynamic>>.from(data);
          widget.isLoading = false;
        });
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

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
        backgroundColor: Colors.blue.shade400,
      ),
      body:
          widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : _categories.isEmpty
              ? Center(
                child: Text("Kategori bulunamadı"),
              ) // Veriler yüklenirken gösterilecek
              : GridView.builder(
                itemCount: _categories.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  var category = _categories[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => CategoryProductsPage(
                                userId: UserService.user!.id,
                                category: category['id'],
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
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              category['image'] ?? '',
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.image_not_supported, size: 50),
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
                              category['name'] ?? '',
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
                  );
                },
              ),
    );
  }
}
