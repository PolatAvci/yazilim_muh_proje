import "package:flutter/material.dart";
import "package:yazilim_muh_proje/components/custom_text_field.dart";
import "package:yazilim_muh_proje/pages/register_page.dart";

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({super.key});

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  String _inputText = "";
  final _email = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  Widget _buildErrorText(bool isValid) {
    return isValid
        ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
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
          ],
        ) // Geçerli ise boş bir container döndür
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //padding: EdgeInsets.only(top: 8.0),
          children: [
            const Text(
              'Geçerli bir e-posta adresi girin',
              style: TextStyle(color: Colors.red),
            ),
            TextButton(
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
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid = _isValidEmail(
      _inputText,
    ); // E-postanın doğruluğunu kontrol et

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade400),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: LoginAppBarTheme.actionsPadding),
            child: TextButton(
              onPressed: isEmailValid ? () {} : null,
              child: Text(
                LoginAppBarTheme.continueText,
                style: TextStyle(
                  color: isEmailValid ? Colors.blue.shade400 : Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(LoginAppBarTheme.mainPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(LoginAppBarTheme.emailImage),
            const SizedBox(height: 30),
            Text(
              LoginAppBarTheme.title,
              style: TextStyle(
                fontSize: LoginAppBarTheme.titleFontsize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(LoginAppBarTheme.subTitle),
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
            _buildErrorText(isEmailValid),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        isEmailValid ? Colors.blue.shade400 : Colors.grey[400],
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed:
                        isEmailValid // E-posta geçerliyse devam et butonunu etkinleştir
                            ? () {}
                            : null,
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
}

bool _isValidEmail(String email) {
  // Basit bir e-posta doğrulama kontrolü
  // Burada daha kapsamlı bir e-posta doğrulama işlemi
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

class LoginAppBarTheme {
  static String continueText = "Devam et";
  static double actionsPadding = 20;
  static double mainPadding = 20;
  static String emailImage = "images/email.png";
  static String title = "E-postanızı girin.";
  static String subTitle = "Hesabınızın olup olmadğını kontrol edeceğiz";
  static double titleFontsize = 26;
}
