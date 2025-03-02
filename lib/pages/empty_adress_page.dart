import "package:flutter/material.dart";
import "package:yazilim_muh_proje/Models/address.dart";
import "package:yazilim_muh_proje/components/empty_page.dart";
import "package:yazilim_muh_proje/pages/add_address_page.dart";

class EmptyAdressPage extends StatefulWidget {
  const EmptyAdressPage({super.key});

  @override
  State<EmptyAdressPage> createState() => _EmptyAdressPageState();
}

class _EmptyAdressPageState extends State<EmptyAdressPage> {
  final List<Address> adresler = [];

  final String description =
      "Henüz adresinizi kaydetmediniz. Başlamak için 'Yeni adres ekle'yi tıklayın.";

  void _addNewAddress(Address newAddress) {
    setState(() {
      adresler.add(newAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      button: "Yeni adres ekle",
      description: description,
      imagePath: "images/adress.png",
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AddAddressPage(
                  adresler: adresler,
                  onAddressAdded: _addNewAddress,
                ),
          ),
        );
      },
      title1: "Adreslerim",
      title2: "Burası boş",
    );
  }
}
