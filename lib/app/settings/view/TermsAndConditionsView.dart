import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  final String privacyText = '''
    Gizlilik Aydınlatma Metni

    Bu Aydınlatma Metni, örnek bir gizlilik açıklaması sunmak amacıyla hazırlanmıştır.

    1. Veri Sorumlusu
    Bu sistemde veri sorumlusu, örnek Şirket Adı (Örnek Şirket) olarak belirtilmiştir. Gerçek veri sorumlusu burada belirtilen bir örnek şirket olmayabilir.

    2. Kişisel Verilerin İşlenme Amaçları ve Hukuki Sebepleri
    Örnek Şirket, kullanıcıların kişisel verilerini aşağıdaki amaçlarla işleyebilir:
    - Hizmet sunumu için gerekli işlemler,
    - İletişim sağlamak için,
    - Ürün ve hizmetlerin iyileştirilmesi için,
    - Kampanya ve duyuruların iletilmesi için,
    - Kanunen gerektiği durumlarda.
    
    // Geri kalan metin burada devam ediyor...

    7. İletişim
    Herhangi bir soru, öneri veya şikayet durumunda bizimle iletişime geçmek için örnek şirketin iletişim bilgileri:
    - Adres: Örnek Adres, Örnek Şehir, Ülke
    - E-posta: info@ornek.com
    - Telefon: 1234567890

    Bu belge, örnek bir gizlilik açıklamasıdır ve gerçek veri sorumlusu ve detayları içermemektedir. Herhangi bir gerçek veri sorumlusuna ait olmadığını lütfen unutmayın.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Şartlar ve Koşullar',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'T.C. SAĞLIK BAKANLIĞI MERKEZİ HEKİM RANDEVU SİSTEMİ AYDINLATMA METNİ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    privacyText,
                    style: TextStyle(fontSize: 16),
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
