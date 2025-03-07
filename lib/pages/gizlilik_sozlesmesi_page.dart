import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/pages/home_page.dart';

class GizlilikSozlesmesiPage extends StatefulWidget {
  const GizlilikSozlesmesiPage({super.key});

  @override
  State<GizlilikSozlesmesiPage> createState() => _GizlilikSozlesmesiPageState();
}

class _GizlilikSozlesmesiPageState extends State<GizlilikSozlesmesiPage> {
  bool isChecked = false;

  final String privacyText =
      "   TrakStore, kullanıcılarının gizliliğine büyük önem vermektedir ve kişisel bilgilerinizi korumak için gerekli tüm güvenlik önlemlerini almaktadır. Uygulamayı kullanarak, belirtilen tüm gizlilik koşullarını kabul etmiş sayılırsınız. Eğer bu koşulları kabul etmiyorsanız, lütfen uygulamayı kullanmayınız.\n\n"
      "   TrakStore, uygulamaya kaydolduğunuzda veya hizmetlerimizi kullandığınızda, kişisel bilgileriniz (isim, e-posta adresi, telefon numarası, adres vb.) tarafımızdan toplanabilir. Bu bilgiler yalnızca kullanıcı deneyiminizi geliştirmek, siparişlerinizi işlemek, müşteri destek hizmeti sağlamak ve yasal yükümlülükleri yerine getirmek için kullanılacaktır. TrakStore, kullanıcı bilgilerini gizli tutarak yalnızca belirtilen amaçlar doğrultusunda kullanır ve kullanıcı bilgileri yalnızca yetkilendirilmiş kişiler tarafından erişilebilir olacaktır. Kullanıcılar, kişisel bilgilerini her zaman güncelleyebilir veya silinmesini talep edebilirler.\n\n"
      "   TrakStore, kullanıcı bilgilerini üçüncü şahıslarla yalnızca anlaşmalı hizmet sağlayıcılarıyla (örneğin, ödeme işlemcileri, kargo şirketleri) gerekli izinlerle paylaşabilir. Ancak, yasal zorunluluklar doğrultusunda yasal mercilerle de paylaşılabilir. TrakStore, gizlilik politikasını zaman zaman güncelleyebilir. Bu nedenle, uygulama üzerinden yapacağımız bildirimleri takip etmeniz önerilir. Gizlilik politikasına ilişkin herhangi bir anlaşmazlık durumunda, Türkiye Cumhuriyeti yasalarına göre çözüme kavuşturulacaktır.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Gizlilik Politikası',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
                  child: Text(privacyText, style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.green,
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
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
