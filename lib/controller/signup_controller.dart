import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/no_internet.dart';
import 'package:brakly_mobile/view/verification_code.dart';

class SignupController extends GetxController {
  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> hide1 = true.obs;
  Rx<bool> hide2 = true.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  signUp(BuildContext context) {
    validate.value = true;
    if (password.text != confirm_password.text) {
      App.error_msg(
          context, App_Localization.of(context).translate("password_err_3"));
    } else {
      loading.value = true;
      if (email.text.isNotEmpty &&
          password.text.isNotEmpty &&
          firstName.text.isNotEmpty &&
          lastName.text.isNotEmpty) {
        API.checkInternet().then((value) async {
          if (value) {
            API.email = email.text;
            API.password = password.text;
            API
                .signUp(
                    firstName.text, lastName.text, email.text, password.text)
                .then((value) {
              loading.value = false;
              if (value) {
                App.sucss_msg(context,
                    App_Localization.of(context).translate("succ_signup"));
                Get.to(() => VerificationCode());
              } else {
                App.error_msg(context,
                    App_Localization.of(context).translate("err_signup"));
              }
            });
          } else {
            Get.to(() => NoInternet())!.then((value) {
              signUp(context);
            });
          }
        }).catchError((err) {
          loading.value = false;
          err.printError();
        });
      }
    }
  }
}
