class Address {
  final String id;
  final String address;
  final String sehir;

  Address({required this.id, required this.address, required this.sehir});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: json['addressInfo'],
      sehir: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'addressInfo': address, 'city': sehir};
  }
}
