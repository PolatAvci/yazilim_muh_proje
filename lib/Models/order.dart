import 'package:yazilim_muh_proje/Models/product.dart';

class Order extends Product {
  final String status;
  final DateTime date;

  Order({
    required this.status,
    required super.id,
    required super.productCategories,
    required super.details,
    required super.name,
    required super.price,
    required super.image,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['productId'],
      name: json['product']['name'],
      price: json['product']['price'].toDouble(),
      details: json['product']['details'],
      image: json['product']['image'],
      status: json['status'],
      productCategories: [],
      date: DateTime.parse(json['date']),
    );
  }

  // Dart modelini JSON'a dönüştürme
  @override
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
