import "package:flutter/material.dart";
import "package:yazilim_muh_proje/components/button.dart";
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
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
           
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.shopify,
                color: Colors.blue.shade400,
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kayıt ol",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Devam etmek için kayıt olun.",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                      Button(
                        text: "Kaydet",
                        buttonColor: Colors.blue.shade400,
                        textColor: Colors.white,
                        fontSize: 13,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
