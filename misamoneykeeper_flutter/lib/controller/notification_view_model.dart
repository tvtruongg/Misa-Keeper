import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/notification.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/service_call.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class NotificationVM extends GetxController {
  final splashVM = Get.find<SplashViewModel>();
  Future<List<NotificationMD>> serviceCallList() async {
    List<NotificationMD> data = [];
    await ServiceCall.post({
      "user_id": splashVM.userModel.value.id.toString(),
    }, SVKey.svNotification, isToken: true, withSuccess: (resObj) async {
      if (resObj[KKey.status] == 1) {
        data = (resObj[KKey.payload] as List? ?? []).map((oObj) {
          return NotificationMD.fromJson(oObj);
        }).toList();
      }
      print(data.length);
    }, failure: (err) async {
      Get.snackbar(appname, err.toString());
    });
    return data;
  }
}
