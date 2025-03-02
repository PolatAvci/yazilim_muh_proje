import "package:flutter/material.dart";
import "package:yazilim_muh_proje/Models/address.dart";

class AddAddressPage extends StatefulWidget {
  final List<Address> adresler;
  final Function(Address) onAddressAdded;

  const AddAddressPage({
    super.key,
    required this.adresler,
    required this.onAddressAdded,
  });

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  void _saveAddress() {
    if (addressController.text.isNotEmpty && cityController.text.isNotEmpty) {
      final newAddress = Address(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        address: addressController.text,
        sehir: cityController.text,
      );

      widget.onAddressAdded(newAddress);
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Adresiniz kaydedildi")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text(
          "Yeni Adres Ekle",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Adres"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: "Şehir"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
