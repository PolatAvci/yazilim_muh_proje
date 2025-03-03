import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/pages/gizlilik_sozlesmesi_page.dart';

class KullanimKosullariPage extends StatefulWidget {
  const KullanimKosullariPage({super.key});

  @override
  _KullanimKosullariPageState createState() => _KullanimKosullariPageState();
}

class _KullanimKosullariPageState extends State<KullanimKosullariPage> {
  bool isChecked = false;

  final String termsText =
      "   TrakStore, kullanıcılarına güvenli, pratik ve kullanıcı dostu bir alışveriş deneyimi sunmayı amaçlamaktadır. Uygulamayı kullanarak, belirtilen tüm koşulları kabul etmiş sayılırsınız. Eğer bu şartları kabul etmiyorsanız, lütfen uygulamayı kullanmayınız. TrakStore'u kullanırken, yasalara ve genel ahlak kurallarına uygun hareket etmekle yükümlüsünüz. Başkalarının haklarını ihlal eden, rahatsız edici, yasa dışı veya yanıltıcı içerikler paylaşmak yasaktır.\n\n"
      "   Kullanıcılar, yalnızca doğru ve güncel bilgilerle uygulamaya kaydolmalı ve platformda gerçekleştirdikleri tüm işlemlerden sorumlu olmalıdır. Ayrıca, hesabınızın güvenliği tamamen sizin sorumluluğunuzdadır. Giriş bilgilerinizin korunmasını sağlamalı ve üçüncü şahıslarla paylaşmamalısınız. Hesabınıza yapılan yetkisiz girişler durumunda TrakStore’a derhal bildirimde bulunmanız gerekmektedir. Uygulama üzerinden yasa dışı faaliyetlerde bulunulması halinde TrakStore, kullanıcıyı platformdan men etme ve yasal işlemler başlatma hakkını saklı tutar.\n\n"
      "   Uygulamaya verdiğiniz kişisel bilgilerin doğruluğu ve güncellenmesi tamamen sizin sorumluluğunuzda olup, TrakStore, kullanıcı bilgilerini gizli tutarak yalnızca belirtilen amaçlar doğrultusunda kullanır. TrakStore, kullanım koşullarında değişiklik yapma hakkına sahiptir ve bu değişiklikler uygulama üzerinden kullanıcılara bildirilir. Kullanım koşullarına ilişkin anlaşmazlıklar, Türkiye Cumhuriyeti yasalarına tabi olacak şekilde çözüme kavuşturulur.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Kullanım Koşulları',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(termsText, style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.green, // Checkbox yeşil olacak
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Text(
                  "Okudum, onayladım",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed:
                  isChecked
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GizlilikSozlesmesiPage(),
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                "Devam Et",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
