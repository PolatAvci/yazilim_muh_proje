import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';
import 'package:yazilim_muh_proje/pages/register_page.dart';
import 'package:yazilim_muh_proje/pages/kullanim_kosullari_page.dart';
import 'package:yazilim_muh_proje/Models/user.dart';
import 'package:yazilim_muh_proje/Models/veriler.dart';

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({super.key});

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  String _inputText = "";
  String _passwordText = "";
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  Widget _buildErrorText(bool isValid) {
    return isValid
        ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Hesabınız yok mu?",
                  style: TextStyle(color: Colors.blue.shade400, fontSize: 12),
                ),
              ),
            ),
          ],
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: const Text(
                'Geçerli bir e-posta adresi girin',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Hesabınız yok mu?",
                  style: TextStyle(color: Colors.blue.shade400),
                ),
              ),
            ),
          ],
        );
  }

  void _login() {
    bool isEmailValid = _isValidEmail(_inputText);
    bool isPasswordValid = _passwordText.isNotEmpty;

    if (isEmailValid && isPasswordValid) {
      User user = Veriler.kullanicilar.firstWhere(
        (user) => user.email == _inputText && user.sifre == _passwordText,
        orElse: () => User(email: "", sifre: ""),
      );

      if (user.email.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KullanimKosullariPage()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Geçersiz e-posta veya şifre")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid = _isValidEmail(_inputText);
    bool isPasswordValid = _passwordText.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: isEmailValid && isPasswordValid ? _login : null,
              child: Text(
                "Devam et",
                style: TextStyle(
                  color:
                      isEmailValid && isPasswordValid
                          ? Colors.white
                          : Colors.grey.shade400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.shopify,
                size: 150,
                color: Colors.blue.shade400,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "E-postanızı ve şifrenizi girin.",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text("E-postanızı ve şifrenizi girin."),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Email girin:",
              label: "E-posta",
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                setState(() {
                  _inputText = text;
                });
              },
            ),
            CustomTextField(
              hint: "Şifre girin:",
              label: "Şifre",
              controller: _password,
              password: true,
              onChanged: (text) {
                setState(() {
                  _passwordText = text;
                });
              },
            ),
            _buildErrorText(isEmailValid),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        isEmailValid && isPasswordValid
                            ? Colors.blue.shade400
                            : Colors.grey[400],
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: isEmailValid && isPasswordValid ? _login : null,
                    child: const Text(
                      "Devam et",
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

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
