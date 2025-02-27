import "package:flutter/material.dart";
import "package:yazilim_muh_proje/components/custom_text_field.dart";

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();
  final _name = TextEditingController();
  final _surname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.shopify, color: Colors.white, size: 50),
            Text(
              "Kayıt ol",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Ad",
                    onChanged: (name) {
                      _name.text = name;
                    },
                    controller: _name,
                    hint: "Ad",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    label: "Soyad",
                    onChanged: (surname) {
                      _surname.text = surname;
                    },
                    controller: _surname,
                    hint: "Soyad",
                  ),
                ),
              ],
            ),
            CustomTextField(
              label: "E-posta",
              onChanged: (email) {
                _email.text = email;
              },
              controller: _email,
              hint: "E-posta",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Şifre",
              onChanged: (password) {
                _password.text = password;
              },
              controller: _password,
              hint: "Şifre",
              password: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Şifre (Tekrar)",
              onChanged: (repassword) {
                _repassword.text = repassword;
              },
              controller: _repassword,
              hint: "Şifre (Tekrar)",
              password: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.blue.shade400,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
