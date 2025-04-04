import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/custom_text_field.dart';
import 'package:yazilim_muh_proje/pages/home_page.dart';
import 'package:yazilim_muh_proje/pages/register_page.dart';

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({super.key});

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  final _emailComtroller = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailComtroller.dispose();
    _passwordController.dispose();
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
    bool isEmailValid = _isValidEmail(_emailComtroller.text);
    bool isPasswordValid = _passwordController.text.isNotEmpty;

    if (isEmailValid && isPasswordValid) {
      UserService.login(_emailComtroller.text, _passwordController.text).then((
        user,
      ) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          // Kullanıcı bulunamadı, hata mesajı göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Geçersiz e-posta veya şifre"),
              showCloseIcon: true,
            ),
          );
        }
      });
    } else {
      // Kullanıcı bulunamadı, hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Geçersiz e-posta veya şifre"),
          showCloseIcon: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid = _isValidEmail(_emailComtroller.text);
    bool isPasswordValid = _passwordController.text.isNotEmpty;

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
              controller: _emailComtroller,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _emailComtroller.text = value;
                });
              },
            ),
            CustomTextField(
              hint: "Şifre girin:",
              label: "Şifre",
              controller: _passwordController,
              password: true,
              onChanged: (value) {
                setState(() {
                  _passwordController.text = value;
                });
              },
            ),
            _buildErrorText(isEmailValid),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        isEmailValid && isPasswordValid
                            ? Colors.blue.shade400
                            : Colors.grey[400],
                      ),
                      shape: WidgetStateProperty.all(
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
