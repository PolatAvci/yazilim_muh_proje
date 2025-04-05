import "package:flutter/material.dart";
import 'package:yazilim_muh_proje/Models/address.dart';
import 'package:yazilim_muh_proje/Services/address_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/button.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Address> adresler = [];
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  void _saveAddress() {
    if (_addressController.text.trim().isNotEmpty &&
        _cityController.text.trim().isNotEmpty) {
      AddressService.addAddress(
        UserService.user!.id,
        _addressController.text.trim(),
        _cityController.text.trim(),
      ).then((response) {
        if (!mounted) return;
        if (response.statusCode == 201) {
          AddressService.getAddresses(UserService.user!.id).then((value) {
            setState(() {
              adresler = value;
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Adresiniz kaydedildi"),
              showCloseIcon: true,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Hata: Adres Kaydedilemedi"),
              showCloseIcon: true,
            ),
          );
        }
      });
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
    AddressService.removeAddress(UserService.user!.id, address.id).then((
      response,
    ) {
      if (response.statusCode == 204) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adres silindi'), showCloseIcon: true),
        );
        setState(() {
          AddressService.getAddresses(UserService.user!.id).then((value) {
            setState(() {
              adresler = value;
            });
          });
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hata: Adres silinemedi'),
            showCloseIcon: true,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    AddressService.getAddresses(UserService.user!.id).then((value) {
      setState(() {
        adresler = value;
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
