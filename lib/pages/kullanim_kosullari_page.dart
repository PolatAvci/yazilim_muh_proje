import 'package:flutter/material.dart';

class KullanimKosullariPage extends StatelessWidget {
  final String termsText =
      "   TrakStore, kullanıcılarına güvenli, pratik ve kullanıcı dostu bir alışveriş deneyimi sunmayı amaçlamaktadır. Uygulamayı kullanarak, belirtilen tüm koşulları kabul etmiş sayılırsınız. Eğer bu şartları kabul etmiyorsanız, lütfen uygulamayı kullanmayınız. TrakStore'u kullanırken, yasalara ve genel ahlak kurallarına uygun hareket etmekle yükümlüsünüz. Başkalarının haklarını ihlal eden, rahatsız edici, yasa dışı veya yanıltıcı içerikler paylaşmak yasaktır.\n\n"
      "   Kullanıcılar, yalnızca doğru ve güncel bilgilerle uygulamaya kaydolmalı ve platformda gerçekleştirdikleri tüm işlemlerden sorumlu olmalıdır. Ayrıca, hesabınızın güvenliği tamamen sizin sorumluluğunuzdadır. Giriş bilgilerinizin korunmasını sağlamalı ve üçüncü şahıslarla paylaşmamalısınız. Hesabınıza yapılan yetkisiz girişler durumunda TrakStore’a derhal bildirimde bulunmanız gerekmektedir. Uygulama üzerinden yasa dışı faaliyetlerde bulunulması halinde TrakStore, kullanıcıyı platformdan men etme ve yasal işlemler başlatma hakkını saklı tutar.\n\n"
      "   Uygulamaya verdiğiniz kişisel bilgilerin doğruluğu ve güncellenmesi tamamen sizin sorumluluğunuzda olup, TrakStore, kullanıcı bilgilerini gizli tutarak yalnızca belirtilen amaçlar doğrultusunda kullanır. TrakStore, kullanım koşullarında değişiklik yapma hakkına sahiptir ve bu değişiklikler uygulama üzerinden kullanıcılara bildirilir. Kullanım koşullarına ilişkin anlaşmazlıklar, Türkiye Cumhuriyeti yasalarına tabi olacak şekilde çözüme kavuşturulur.";

  const KullanimKosullariPage({super.key});

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
          style: TextStyle(color: Colors.white), // Kalın yazı
        ),
        backgroundColor: Colors.blue.shade400,
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
            child: Text(termsText, style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
