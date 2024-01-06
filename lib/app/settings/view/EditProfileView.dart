import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart'; // Profil verileri için controller
import 'package:s_medi/general/consts/consts.dart';

class EditProfileView extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  List<String> bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  Widget _buildTextField(String label, RxString value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Metin rengini mavi yap
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: value.value,
          onChanged: (val) => value.value = val,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Border rengini mavi yap
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Odaklandığında border rengini mavi yap
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.grey[200], // TextFormField arka plan rengi
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBloodGroupField(
      String label, RxString value, BuildContext context) {
    String? selectedBloodGroupDisplay = value.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Metin rengini mavi yap
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          controller:
          TextEditingController(text: selectedBloodGroupDisplay ?? ''),
          onTap: () async {
            String? selectedBloodGroup = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Kan Grubu Seçin'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: bloodGroupOptions.map((String group) {
                      return ListTile(
                        title: Text(group),
                        leading: Radio<String>(
                          value: group,
                          groupValue: value.value,
                          onChanged: (String? newValue) {
                            selectedBloodGroupDisplay =
                                newValue; // Sadece görüntülenmek üzere tutulan değeri güncelle
                            Navigator.pop(context, newValue);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Diyalogdan çıkış
                      },
                      child: Text('Kapat'),
                    ),
                  ],
                );
              },
            );

            if (selectedBloodGroup != null) {
              value.value = selectedBloodGroup; // Seçilen Kan Grubunu set etme
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Border rengini mavi yap
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Odaklandığında border rengini mavi yap
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.grey[200], // TextFormField arka plan rengi
          ),
        ),


        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Düzenle'),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.updateUserData(
                controller.username.value,
                controller.email.value,
                controller.bloodGroup.value, // Kan grubu
                controller.age.value, // Yaş
                controller.weight.value, // Kilo
                controller.height.value,
                controller.phone.value,// Boy
              );
              Get.snackbar(
                'Başarı',
                'Profil başarıyla güncellendi',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('İsim Soyisim', controller.username),
            _buildTextField('E-posta', controller.email),
            _buildTextField('Telefon', controller.phone),

          ],
        ),
      ),
    );
  }
}
