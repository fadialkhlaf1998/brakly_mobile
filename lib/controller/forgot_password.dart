import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/no_internet.dart';

class ForgotPasswordController extends GetxController {
  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;

  TextEditingController email = TextEditingController();

  submit(BuildContext context) {
    validate.value = true;
    if (email.text.isNotEmpty) {
      loading.value = true;
      API.checkInternet().then((value) async {
        if (value) {
          API.forgot_password(email.text).then((value) {
            loading.value = false;
            if (value) {
              App.sucss_msg(context,
                  App_Localization.of(context).translate("succ_sent_password"));
              Get.back();
            } else {
              App.error_msg(
                  context, App_Localization.of(context).translate("oops"));
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            submit(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
}
