import 'package:flutter/material.dart';

class GizlilikSozlesmesiPage extends StatelessWidget {
  final String privacyText =
      "   TrakStore, kullanıcılarının gizliliğine büyük önem vermektedir ve kişisel bilgilerinizi korumak için gerekli tüm güvenlik önlemlerini almaktadır. Uygulamayı kullanarak, belirtilen tüm gizlilik koşullarını kabul etmiş sayılırsınız. Eğer bu koşulları kabul etmiyorsanız, lütfen uygulamayı kullanmayınız.\n\n"
      "   TrakStore, uygulamaya kaydolduğunuzda veya hizmetlerimizi kullandığınızda, kişisel bilgileriniz (isim, e-posta adresi, telefon numarası, adres vb.) tarafımızdan toplanabilir. Bu bilgiler yalnızca kullanıcı deneyiminizi geliştirmek, siparişlerinizi işlemek, müşteri destek hizmeti sağlamak ve yasal yükümlülükleri yerine getirmek için kullanılacaktır. TrakStore, kullanıcı bilgilerini gizli tutarak yalnızca belirtilen amaçlar doğrultusunda kullanır ve kullanıcı bilgileri yalnızca yetkilendirilmiş kişiler tarafından erişilebilir olacaktır. Kullanıcılar, kişisel bilgilerini her zaman güncelleyebilir veya silinmesini talep edebilirler.\n\n"
      "   TrakStore, kullanıcı bilgilerini üçüncü şahıslarla yalnızca anlaşmalı hizmet sağlayıcılarıyla (örneğin, ödeme işlemcileri, kargo şirketleri) gerekli izinlerle paylaşabilir. Ancak, yasal zorunluluklar doğrultusunda yasal mercilerle de paylaşılabilir. TrakStore, gizlilik politikasını zaman zaman güncelleyebilir. Bu nedenle, uygulama üzerinden yapacağımız bildirimleri takip etmeniz önerilir. Gizlilik politikasına ilişkin herhangi bir anlaşmazlık durumunda, Türkiye Cumhuriyeti yasalarına göre çözüme kavuşturulacaktır.";

  const GizlilikSozlesmesiPage({super.key});

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
          style: TextStyle(color: Colors.white), // Kalın yazı
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Scrollable hale getirdim
          child: Container(
            padding: EdgeInsets.all(8.0), // Container içine padding ekledim
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Arka plan rengi
              borderRadius: BorderRadius.circular(8.0), // Köşeleri yuvarlama
            ),
            child: Text(privacyText, style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
