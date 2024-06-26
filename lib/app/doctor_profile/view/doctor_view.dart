import 'package:s_medi/app/widgets/coustom_button.dart';
import 'package:s_medi/general/consts/consts.dart';

import '../../book_appointment/view/appointment_view.dart';

class DoctorProfile extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "Doktor Bilgileri".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      height: 75,
                      width: 75,
                      child: Image.network(
                        doc['doctorImage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    15.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        doc['docName']
                            .toString()
                            .text
                            .size(AppFontSize.size18)
                            .make(),
                        doc['docCategory'].toString().text.make(),
                        8.heightBox,
                        VxRating(
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value: double.parse(doc['docRating'].toString()),
                          stepInt: true,
                        ),
                      ],
                    ),
                    const Spacer(),
                    "Tüm İncelemeleri Gör".text.color(AppColors.primeryColor).make()
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Hakkında".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAbout']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Adres".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAddress']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Çalışma Saatleri"
                        .text
                        .semiBold
                        .size(AppFontSize.size18)
                        .make(),
                    5.heightBox,
                    doc['docTimeing']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Hizmetler".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docService']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    25.heightBox,
                    ListTile(
                      title: "İletişim Bilgileri"
                          .text
                          .semiBold
                          .size(AppFontSize.size16)
                          .make(),
                      subtitle: "İletişim Bilgilerini Görüntülemek İçin Öncelikle Randevu Oluşturun"
                          .text
                          .size(AppFontSize.size12)
                          .make(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CoustomButton(
            onTap: () {
              Get.to(
                () => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                  docNum: doc['docPhone'],
                ),
              );
            },
            title: "Randevu Oluştur"),
      ),
    );
  }
}
