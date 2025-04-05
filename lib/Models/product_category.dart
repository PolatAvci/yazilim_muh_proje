class ProductCategory {
  final int productId;
  final int categoryId;

  ProductCategory({required this.productId, required this.categoryId});

  // JSON'dan dart modeline dönüştürme
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      productId: json['productId'],
      categoryId: json['categoryId'],
    );
  }

  // Dart modelini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {'productId': productId, 'categoryId': categoryId};
  }
}
