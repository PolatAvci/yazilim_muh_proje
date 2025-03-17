class Product {
  int id;
  String name;
  double price;
  String category;
  String details;
  String image;
  int quantity = 1;

  Product({
    required this.id,
    required this.category,
    required this.details,
    required this.name,
    required this.price,
    required this.image,
  });

  void miktarArttir() {
    quantity++;
  }

  void miktarAzalt() {
    quantity--;
  }
}
