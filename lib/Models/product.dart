import 'package:yazilim_muh_proje/Models/product_category.dart';

class Product {
  int id;
  String name;
  double price;
  String details;
  String image;
  final List<ProductCategory> productCategories;
  int quantity = 1;

  Product({
    required this.id,
    required this.details,
    required this.name,
    required this.price,
    required this.image,
    required this.productCategories,
  });

  void miktarArttir() {
    quantity++;
  }

  void miktarAzalt() {
    quantity--;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      details: json['details'],
      image: json['image'],
      productCategories:
          (json['productCategories'] as List)
              .map((e) => ProductCategory.fromJson(e))
              .where(
                (pc) => pc.productId == json['id'],
              ) // Yalnızca bu ürüne ait kategorileri al
              .toList(),
    );
  }

  // Dart modelini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'details': details,
      'image': image,
      'productCategories': productCategories.map((e) => e.toJson()).toList(),
    };
  }
}
