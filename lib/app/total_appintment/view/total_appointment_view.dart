import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:s_medi/app/total_appintment/controller/total_appointment.dart';
import '../../appointment_details/view/appointment_details.dart';
import 'package:s_medi/general/consts/consts.dart';

class TotalAppointment extends StatelessWidget {
  const TotalAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put((TotalAppointmentcontroller()));

    Future<void> _showCancelConfirmationDialog(
        String docId, TotalAppointmentcontroller controller) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Randevuyu iptal etmek istiyor musunuz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hayır'),
              ),
              TextButton(
                onPressed: () async {
                  await controller.cancelAppointment(docId);
                  Navigator.of(context).pop();
                },
                child: const Text('Evet'),
              ),
            ],
          );
        },
      );
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: Text('Tüm Randevular'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.warning, size: 50),
                  SizedBox(height: 20),
                  Text('Randevunuz bulunmamaktadır.'),
                  Text('Yeni randevu oluşturmak için menüyü kullanabilirsiniz.'),
                ],
              ),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => Appointmentdetails(doc: data![index]));
                      },
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            AppAssets.imgDoctor,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      title: Text(
                        data![index]['appDocName'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${data![index]['appDay']} - ${data![index]['appTime']}",
                        style: TextStyle(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          _showCancelConfirmationDialog(
                              data![index].id, controller);
                        },
                      ),

                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
