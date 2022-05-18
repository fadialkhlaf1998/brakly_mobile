import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/no_internet.dart';
import 'package:brakly_mobile/view/verification_code.dart';

class ChangePasswordController extends GetxController {
  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> hide1 = true.obs;
  Rx<bool> hide2 = true.obs;
  Rx<bool> hide3 = true.obs;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  submit(BuildContext context) {
    validate.value = true;
    if (oldPassword.text.isNotEmpty &&
        newPassword.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty) {
      if (oldPassword.text != API.password) {
        App.error_msg(
            context, App_Localization.of(context).translate("password_err_1"));
      } else if (newPassword.text != confirmPassword.text) {
        App.error_msg(
            context, App_Localization.of(context).translate("password_err_2"));
      } else {
        loading.value = true;
        API.checkInternet().then((value) async {
          if (value) {
            API.change_password(newPassword.text).then((value) {
              loading.value = false;
              if (value) {
                App.sucss_msg(
                    context,
                    App_Localization.of(context)
                        .translate("succ_change_password"));
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
}
