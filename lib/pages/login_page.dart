import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/components/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                ), // 100 -> 50 küçültüldü
                child: Icon(Icons.shopify, size: 150, color: Colors.white),
              ),
              Expanded(flex: 1, child: Spacer()),
              Expanded(
                flex: 2,
                // Ekranın geri kalanını kaplaması için eklendi
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20), // İç boşluklar ayarlandı
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Kaydol veya giriş yap',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Button(
                        icon: Icons.add,
                        text: "Hesap oluştur",
                        buttonColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 14,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      Button(
                        icon: Icons.mail_outline_outlined,
                        text: "E-posta ile devam et",
                        buttonColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 14,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: "Devam etmek suretiyle "),
                            TextSpan(
                              style: TextStyle(color: Colors.blue.shade400),
                              text: "Kullanım Koşulları ",
                            ),
                            const TextSpan(text: "ve "),
                            TextSpan(
                              style: TextStyle(color: Colors.blue.shade400),
                              text: "Gizlilik Politikamızı ",
                            ),
                            const TextSpan(text: "kabul etmiş olursunuz."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
