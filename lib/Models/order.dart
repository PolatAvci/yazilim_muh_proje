import 'package:yazilim_muh_proje/Models/product.dart';

class Order extends Product {
  final String customerName;
  final String status;

  Order({
    required this.customerName,
    required this.status,
    required super.id,
    required super.category,
    required super.details,
    required super.name,
    required super.price,
    required super.image,
  });
}
