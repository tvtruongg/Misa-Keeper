import 'package:misamoneykeeper_flutter/utility/export.dart';

class ChangeInfoModel extends GetxController {
  final txtName = TextEditingController().obs;
  final txtPhone = TextEditingController().obs;
  final txtEmail = TextEditingController().obs;
  final txtBirth = TextEditingController().obs;
  final txtAddress = TextEditingController().obs;
  final txtJob = TextEditingController().obs;
  final nameFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final birthFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final jobFocusNode = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
    txtName.value.text = "Từ Minh Hiếu";
    txtPhone.value.text = "0559311732";
    txtEmail.value.text = "tuminhhieu111@gmail.com";
    txtBirth.value.text = "28/12/2002";
    txtAddress.value.text = "Hà Nội";
    txtJob.value.text = "Nông dân";
  }
}
