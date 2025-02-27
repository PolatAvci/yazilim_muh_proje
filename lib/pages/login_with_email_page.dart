import "package:flutter/material.dart";
import "package:yazilim_muh_proje/components/custom_text_field.dart";
import "package:yazilim_muh_proje/pages/register_page.dart";

class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({super.key});

  @override
  State<LoginWithEmailPage> createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
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
        ) // Geçerli ise boş bir container döndür
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //padding: EdgeInsets.only(top: 8.0),
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

  @override
  Widget build(BuildContext context) {
    bool isEmailValid = _isValidEmail(
      _inputText,
    ); // E-postanın doğruluğunu kontrol et

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
              onPressed: isEmailValid ? () {} : null,
              child: Text(
                "Devam et",
                style: TextStyle(
                  color: isEmailValid ? Colors.white : Colors.grey.shade400,
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
              "E-postanızı girin.",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text("E-postanızı girin."),
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
