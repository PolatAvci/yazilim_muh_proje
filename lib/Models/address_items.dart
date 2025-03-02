import 'package:yazilim_muh_proje/Models/address.dart';

class AddressItems {
  // Adres listesi
  static List<Address> adresler = [
    Address(id: "1", address: "İstiklal Caddesi No:5", sehir: "İstanbul"),
    Address(id: "2", address: "Atatürk Bulvarı No:12", sehir: "Ankara"),
    Address(id: "3", address: "Konak Mah. 123. Sokak", sehir: "İzmir"),
  ];

  // Yeni adres ekleme fonksiyonu
  static void addAddress(Address newAddress) {
    adresler.add(newAddress);
  }
}
