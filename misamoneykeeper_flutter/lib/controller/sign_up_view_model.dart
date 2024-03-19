import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/auth/login_view.dart';

class SignUpVM extends GetxController {
  final txtEmail = TextEditingController().obs;
  final txtPassword = TextEditingController().obs;
  final txtConfirmPass = TextEditingController().obs;
  final txtTenDem = TextEditingController().obs;
  final txtTen = TextEditingController().obs;
  final txtSDT = TextEditingController().obs;

  final isShowPasswordLogin = false.obs;
  final isShowConfirmPassLogin = false.obs;
  final isLoading = false.obs;

  void serviceCallSignUp() async {
    isLoading(true);
    await ServiceCall.post({
      "first_name": txtTenDem.value.text,
      "last_name": txtTen.value.text,
      "email": txtEmail.value.text,
      "mobile": txtSDT.value.text,
      "password": txtPassword.value.text,
      "type": "1",
      "is_superuser": "False",
      "is_staff": "False",
      "is_active": "1"
    }, SVKey.svSignUp, withSuccess: (resObj) async {
      isLoading(false);
      if (resObj[KKey.status] == 1) {
        Get.to(() => const LoginView(), transition: Transition.leftToRight);
        Get.snackbar("MiSa", "Bạn đã đăng kí thành công");
      }
    }, failure: (err) async {
      Get.snackbar("MiSA", err.toString());
    });
    isLoading(false);
  }

  void showPassword() {
    isShowPasswordLogin.value = !isShowPasswordLogin.value;
  }

  void showConfirmPass() {
    isShowConfirmPassLogin.value = !isShowConfirmPassLogin.value;
  }
}
