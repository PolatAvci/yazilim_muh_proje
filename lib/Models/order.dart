import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:yazilim_muh_proje/Models/product_category.dart';

class Order extends Product {
  final String status;

  Order({
    required this.status,
    required super.id,
    required super.productCategories,
    required super.details,
    required super.name,
    required super.price,
    required super.image,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      details: json['details'],
      image: json['image'],
      status: json['status'],
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
      'status': status,
      'productCategories': productCategories.map((e) => e.toJson()).toList(),
    };
  }
}
