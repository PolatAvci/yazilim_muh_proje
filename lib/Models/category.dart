class Category {
  int id;
  String image;
  String name;
  Category({required this.id, required this.name, required this.image});

  // JSON'dan dart modeline dönüştürme
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], image: json['image']);
  }

  // Dart modelini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
