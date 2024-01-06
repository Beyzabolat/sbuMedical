import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:s_medi/app/auth/controller/signup_controller.dart';
import 'package:s_medi/app/auth/view/login_page.dart';
import 'package:s_medi/general/consts/consts.dart';

import '../../widgets/coustom_iconbutton.dart';
import '../controller/profile_controller.dart';
import '../view/EditProfileView.dart';
import '../view/DetailedInfoView.dart';
import '../view/ChangePasswordView.dart';
import '../view/TermsAndConditionsView.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(
            () => profileController.isLoading.value
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileController.username.value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Kullanıcı adının rengini ayarlayabilirsiniz
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      profileController.email.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87, // E-posta rengini ayarlayabilirsiniz
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      profileController.phone.value, // Telefon numarasını ekleyin
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87, // Telefon numarası rengini ayarlayabilirsiniz
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileDetail(
                    icon: Icons.opacity,
                    title: 'Kan Grubu',
                    value: profileController.bloodGroup.value,
                  ),
                  _buildProfileDetail(
                    icon: Icons.cake,
                    title: 'Yaş',
                    value: profileController.age.value,
                  ),
                  _buildProfileDetail(
                    icon: Icons.monitor_weight,
                    title: 'Kilo',
                    value: profileController.weight.value,
                  ),
                  _buildProfileDetail(
                    icon: Icons.height,
                    title: 'Boy',
                    value: profileController.height.value,
                  ),
                ],
              ),
              SizedBox(height: 30),
              _buildSettingsItem(
                "Profil Düzenle",
                Icons.edit,
                    () {
                  Get.to(() => EditProfileView());
                },
              ),
              Divider(),
              _buildSettingsItem(
                "Detaylı Bilgiler", // Detaylı Bilgiler butonu
                Icons.info,
                    () {
                  Get.to(() => DetailedInfoView()); // Detaylı Bilgiler sayfasına geçiş
                },
              ),
              Divider(),
              _buildSettingsItem(
                "Şifre Değiştir",
                Icons.lock,
                    () {
                  Get.to(() => ChangePasswordView()); // Şifre değiştirme sayfasına yönlendirme
                },
              ),

              Divider(),
              _buildSettingsItem(
                "Şartlar ve Koşullar",
                Icons.edit_document,
                    () {
                  Get.to(() => TermsAndConditionsView());
                },
              ),

              Divider(),
              _buildSettingsItem(
                "Çıkış Yap",
                Icons.logout,
                    () {
                  // Çıkış yap işlevi burada gerçekleştirilecek
                  // Örneğin, çıkış yapmak için bir fonksiyon çağrısı yapılabilir
                  SignupController().signout();
                  Get.offAll(() => const LoginView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        FaIcon( // FontAwesome ikonları için FaIcon kullanıyoruz
          icon,
          size: 36,
          color: Colors.blue, // İkon rengini ayarlayabilirsiniz
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
  Widget _buildSettingsItem(String title, IconData icon, Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}