import 'package:s_medi/app/book_appointment/controller/book_appointment_controller.dart';
import 'package:s_medi/app/widgets/coustom_textfield.dart';
import 'package:intl/intl.dart';
import '../../../general/consts/consts.dart';
import '../../widgets/coustom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BookAppointmentView extends StatelessWidget {

  final String docId;
  final String docNum;
  final String docName;
  const BookAppointmentView({
    super.key,
    required this.docId,
    required this.docName,
    required this.docNum,

  });
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // Seçilen zamanı burada kullanabilirsiniz
      final String formattedTime = picked.format(context);
      print('Seçilen zaman: $formattedTime');
    }
  }
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: docName.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... Diğer text field'lar
                10.heightBox,
                "Randevu Tarihi Seçin"
                    .text
                    .size(AppFontSize.size16)
                    .semiBold
                    .make(),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );
                    if (picked != null && picked != selectedDate) {
                      // Seçilen tarih güncelleme işlemleri
                      selectedDate = picked;
                      controller.appDayController.text =
                          DateFormat('dd-MM-yyyy').format(picked);                    }
                  },
                  child: AbsorbPointer(
                    child: CoustomTextField(
                      validator: controller.validdata,
                      textcontroller: controller.appDayController,
                      hint: "Tarih Seçiniz",
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                ),
                10.heightBox,
                "Randevu Saati Seçin"
                    .text
                    .size(AppFontSize.size16)
                    .semiBold
                    .make(),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      // Seçilen zamanı saklayın ve metin alanına atayın
                      final String formattedTime ="${picked.hour}:${picked.minute}";
                      controller.appTimeController.text = formattedTime;
                    }
                  },
                  child: AbsorbPointer(
                    child: CoustomTextField(
                      validator: controller.validdata,
                      textcontroller: controller.appTimeController,
                      hint: "Saat Seçiniz",
                      icon: const Icon(Icons.watch_later),
                    ),
                  ),
                ),

                10.heightBox,
                "Hasta Adı".text.size(AppFontSize.size16).semiBold.make(),
                CoustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appNameController,
                  hint: "Hastanın Tam Adı",
                  icon: const Icon(Icons.person),
                ),
                10.heightBox,
                "Cep Telefonu Numarası".text.size(AppFontSize.size16).semiBold.make(),
                CoustomTextField(
                  validator: controller.validdata,
                  textcontroller: controller.appMobileController,
                  hint: "Hastanın cep telefonu numarasını giriniz",
                  icon: const Icon(Icons.call),
                ),
                10.heightBox,
                "Şikayetiniz Nedir?".text.size(AppFontSize.size16).semiBold.make(),
                TextFormField(
                  controller: controller.appMessageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.note_add),
                    hintText: "Kısaca şikayetinizi açıklayınız.",
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CoustomButton(
                  onTap: () async {
                    await controller.bookAppointment(
                        docId, docName, docNum, context);
                  },
                  title: "Randevuyu Onayla",
                ),
        ),
      ),
    );
  }
}
