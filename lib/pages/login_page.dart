import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/components/button.dart';
import 'kullanim_kosullari_page.dart';
import 'gizlilik_sozlesmesi_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Icon(Icons.shopify, size: 150, color: Colors.white),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
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
                      Flexible(child: const SizedBox(height: 20)),
                      Button(
                        icon: Icons.add,
                        text: "Hesap oluştur",
                        buttonColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 14,
                        onPressed: () {},
                      ),
                      Flexible(child: const SizedBox(height: 20)),
                      Button(
                        icon: Icons.mail_outline_outlined,
                        text: "E-posta ile devam et",
                        buttonColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 14,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: "Devam etmek suretiyle "),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                KullanimKosullariPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Kullanım Koşulları ",
                                    style: TextStyle(
                                      color: Colors.blue.shade400,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(text: "ve "),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                GizlilikSozlesmesiPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Gizlilik Politikamızı ",
                                    style: TextStyle(
                                      color: Colors.blue.shade400,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(text: "kabul etmiş olursunuz."),
                            ],
                          ),
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
