import "package:flutter/material.dart";
import 'package:yazilim_muh_proje/Models/address.dart';
import 'package:yazilim_muh_proje/Services/address_service.dart';
import 'package:yazilim_muh_proje/components/button.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';

class AddressPage extends StatefulWidget {
  final int userId;
  List<Address> adresler = [];
  AddressPage({super.key, required this.userId});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  void _saveAddress() {
    if (_addressController.text.isNotEmpty && _cityController.text.isNotEmpty) {
      final newAddress = Address(
        id: 1, //DateTime.now().millisecondsSinceEpoch.toString(),
        address: _addressController.text,
        sehir: _cityController.text,
      );

      widget.adresler.add(newAddress);

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
      widget.adresler.removeWhere((a) => a.id == address.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Adres silindi'), showCloseIcon: true),
    );
  }

  @override
  void initState() {
    super.initState();

    AddressService.getAddresses(widget.userId).then((value) {
      setState(() {
        widget.adresler = value;
      });
    });
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
          widget.adresler.isEmpty
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
                itemCount: widget.adresler.length,
                itemBuilder: (context, index) {
                  final address = widget.adresler[index];
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
