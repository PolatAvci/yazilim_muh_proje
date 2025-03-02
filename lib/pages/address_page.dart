import "package:flutter/material.dart";
import 'package:yazilim_muh_proje/Models/address.dart';
import 'package:yazilim_muh_proje/components/button.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';

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
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  void _saveAddress() {
    if (_addressController.text.isNotEmpty && _cityController.text.isNotEmpty) {
      final newAddress = Address(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        address: _addressController.text,
        sehir: _cityController.text,
      );

      adresler.add(newAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Adresiniz kaydedildi"),
          showCloseIcon: true,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lütfen tüm alanları doldurun."),
          showCloseIcon: true,
        ),
      );
    }
  }

  void _deleteAddress(Address address) {
    setState(() {
      adresler.removeWhere((a) => a.id == address.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Adres silindi'), showCloseIcon: true),
    );
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Text("Adres Ekle"),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              ); //Dialog penceresini kapatmak için
                            },
                            icon: Icon(Icons.close, color: Colors.black),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              label: "Adres",
                              onChanged: (address) {
                                _addressController.text = address;
                              },
                              controller: _addressController,
                              hint: "Adres",
                            ),
                            CustomTextField(
                              label: "Şehir",
                              onChanged: (city) {
                                _cityController.text = city;
                              },
                              controller: _cityController,
                              hint: "Şehir",
                            ),
                            Button(
                              text: "Kaydet",
                              buttonColor: Colors.blue.shade400,
                              textColor: Colors.white,
                              fontSize: 15,
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context); //Dialog kapatmak için
                                  _saveAddress();
                                  _addressController.text = "";
                                  _cityController.text = "";
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
            ),
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
                  "Adres bulunamadı",
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
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Adres: ${address.address}  Şehir: ${address.sehir}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteAddress(address),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
