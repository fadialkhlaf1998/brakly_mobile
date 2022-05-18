import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/no_internet.dart';

class LoginController extends GetxController {
  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> hide = true.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login(BuildContext context) {
    validate.value = true;
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      loading.value = true;
      API.checkInternet().then((value) async {
        if (value) {
          API.email = email.text;
          API.password = password.text;
          API.login().then((value) {
            loading.value = false;
            if (value != null) {
              App.sucss_msg(context,
                  App_Localization.of(context).translate("succ_login"));
              Get.offAll(() => Home());
            } else {
              App.error_msg(
                  context, App_Localization.of(context).translate("err_login"));
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            login(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
}
