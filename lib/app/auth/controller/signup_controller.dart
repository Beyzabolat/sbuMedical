import 'package:s_medi/general/consts/consts.dart';
import 'dart:developer';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;
  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  signupUser(context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential != null) {
          var store = FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential!.user!.uid);
          await store.set({
            'uid': userCredential!.user!.uid,
            'fullname': nameController.text,
            'password': passwordController.text,
            'email': emailController.text,
          });
          VxToast.show(context, msg: "Kaydınız Başarıyla Oluşturuldu");
        }
        isLoading(false);
      } catch (e) {
        isLoading(false);
        // Check the type of exception and show a toast accordingly
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            // The email address is already in use by another account
            VxToast.show(context, msg: "Zaten bir hesabınız var mı?");
          } else {
            // Handle other FirebaseAuth exceptions
            VxToast.show(context, msg: "İnternet bağlantısı yok.");
          }
        } else {
          // Handle other exceptions (not related to FirebaseAuth)
          VxToast.show(context, msg: "Bir süre sonra yeniden deneyin. ");
        }
        log("$e");
      }
    }
  }

  storeUserData(
      String uid, String fullname, String email, String password) async {
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store.set({
      'uid': uid,
      'fullname': fullname,
      'password': email,
      'email': password,
    });
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  //vlidateemail
  String? validateemail(value) {
    if (value!.isEmpty) {
      return 'Lütfen bir e-posta adresi giriniz';
    }
    RegExp emailRefExp = RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Lütfen geçerli bir e-posta adresi girin.';
    }
    return null;
  }

  //validate pass
  String? validpass(value) {
    if (value!.isEmpty) {
      return 'Lütfen bir şifre girin.';
    }
    // Check for at least one capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifre en az bir büyük harf içermelidir.';
    }
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifre en az bir rakam içermelidir.';
    }
    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Şifre en az bir özel karakter içermelidir (!@#\$&*~).';
    }
    // Check for overall pattern
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Şifreniz en az 8 karakter içermelidir.';
    }

    return null;
  }

  //validate name
  String? validname(value) {
    if (value!.isEmpty) {
      return 'Lütfen bir şifre giriniz.';
    }
    RegExp emailRefExp = RegExp(r'^.{5,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Geçerli bir isim giriniz.';
    }
    return null;
  }
}
