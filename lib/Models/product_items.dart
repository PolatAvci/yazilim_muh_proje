import 'package:yazilim_muh_proje/Models/product.dart';

class ProductItems {
  static List<Product> items = [
    Product(
      id: 1,
      category: "Elbise",
      details: "Kırmızı elbise",
      name: "Ürün 1",
      price: 500,
      image: "images/elbise.jpg",
    ),
    Product(
      id: 2,
      category: "Kapüşon",
      details: "Gri sweatshirt",
      name: "Ürün 2",
      price: 300,
      image: "images/sweatshirt.jpg",
    ),
    Product(
      id: 3,
      category: "Elbise",
      details: "Kırmızı elbise",
      name: "Ürün 3",
      price: 200,
      image: "images/elbise.jpg",
    ),
    Product(
      id: 4,
      category: "Kapüşon",
      details: "Gri sweatshirt",
      name: "Ürün 4",
      price: 100,
      image: "images/sweatshirt.jpg",
    ),
  ];
}
