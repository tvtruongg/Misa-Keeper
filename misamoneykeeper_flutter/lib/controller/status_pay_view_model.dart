import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/status_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class StatusPayViewModel extends GetxController {
  final splashVM = Get.find<SplashViewModel>();

  Future<List<StatusModel>> serviceCallStatusPay() async {
    List<StatusModel> account = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
      "p_type": 1.toString()
    }, SVKey.svStatus, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        account = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return StatusModel.fromJson(oObj);
        }).toList();
      }
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return account;
  }
}
