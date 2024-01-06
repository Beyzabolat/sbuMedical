import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs;
  var bloodGroup = ''.obs;
  var age = ''.obs;
  var weight = ''.obs;
  var height = ''.obs;
  var phone = ''.obs; // New phone number field

  List<String> bloodGroupOptions = [
    '0rh-',
    'abrh+',
    'abrh-',
    'A+',
    'B-',
    'O+',
    'O-',
  ];

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
  Future<void> logoutFunction() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Oturum kapatma işlemi başarıyla gerçekleşti
      // Yönlendirme veya diğer işlemler burada gerçekleştirilebilir
    } catch (e) {
      print('Oturum kapatılırken bir hata oluştu: $e');
    }
  }
  Future<void> getUserData() async {
    isLoading(true);
    try {
      if (currentUser != null) {
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          username.value = userData['fullname'] ?? "";
          email.value = userData['email'] ?? "";
          bloodGroup.value = userData['bloodGroup'] ?? "";
          age.value = userData['age'] ?? "";
          weight.value = userData['weight'] ?? "";
          height.value = userData['height'] ?? "";
          phone.value = userData['phone'] ?? ""; // Retrieve phone number data
        }
      }
    } catch (e) {
      print('Kullanıcı verileri alınamadı. $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUserData(
      String newName,
      String newEmail,
      String newBloodGroup,
      String newAge,
      String newWeight,
      String newHeight,
      String newPhone,
      ) async {
    try {
      isLoading(true);
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
          'fullname': newName,
          'email': newEmail,
          'bloodGroup': newBloodGroup,
          'age': newAge,
          'weight': newWeight,
          'height': newHeight,
          'phone': newPhone,
        });

        await getUserData();
        Get.back();
      }
    } catch (e) {
      print('Veri güncellenirken hata oluştu. $e');
    } finally {
      isLoading(false);
    }
  }
}
