import 'package:s_medi/general/consts/consts.dart';

class LoginController extends GetxController {
  UserCredential? userCredential;
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //login if user enter validate email and password
  loginUser(context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        isLoading(false);
        VxToast.show(context, msg: "Giriş İşlemi Başarılı");
      } catch (e) {
        isLoading(false);
        VxToast.show(context, msg: "Yanlış email veya şifre");
      }
    }
  }

  //validate email and password
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

  String? validpass(value) {
    if (value!.isEmpty) {
      return 'Lütfen bir şifre girin.';
    }
    RegExp emailRefExp = RegExp(r'^.{8,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Şifre en az 8 karakter içermelidir.';
    }
    return null;
  }
}
