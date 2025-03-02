import "package:flutter/material.dart";
import 'package:yazilim_muh_proje/Models/address.dart';
import 'package:yazilim_muh_proje/pages/add_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Address> adresler = [
    Address(id: "1", address: "İstiklal Caddesi No:5", sehir: "İstanbul"),
    Address(id: "2", address: "Atatürk Bulvarı No:12", sehir: "Ankara"),
    Address(id: "3", address: "Konak Mah. 123. Sokak", sehir: "İzmir"),
  ];

  void _addNewAddress(Address newAddress) {
    setState(() {
      adresler.add(newAddress);
    });
  }

  void _deleteAddress(Address address) {
    setState(() {
      adresler.removeWhere((a) => a.id == address.id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Adres silindi')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text(
          "Adreslerim",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text("Ekle"),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body:
          adresler.isEmpty
              ? const Center(
                child: Text(
                  "Burada adres bulunamadı",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: adresler.length,
                itemBuilder: (context, index) {
                  final address = adresler[index];
                  return Row(
                    children: [
                      ListTile(
                        title: Text(
                          "Adres: ${address.address}  Şehir: ${address.sehir}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteAddress(address),
                        ),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
