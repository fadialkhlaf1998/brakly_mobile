import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/no_internet.dart';

class VerificationCodeController extends GetxController {
  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;

  TextEditingController code = TextEditingController();

  verify(BuildContext context) {
    validate.value = true;
    loading.value = true;
    if (code.text.isNotEmpty) {
      API.checkInternet().then((value) async {
        if (value) {
          API.verify(API.email, code.text).then((value) {
            loading.value = false;
            if (value) {
              App.sucss_msg(context,
                  App_Localization.of(context).translate("succ_verify"));
              Get.offAll(() => Home());
            } else {
              App.error_msg(context,
                  App_Localization.of(context).translate("err_verify"));
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            verify(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }

  resend(BuildContext context) {
    print(API.email);
    if (API.email.isNotEmpty) {
      loading.value = true;
      API.checkInternet().then((value) async {
        if (value) {
          API.resendCode(API.email).then((value) {
            loading.value = false;
            if (value) {
              App.sucss_msg(context,
                  App_Localization.of(context).translate("succ_resend_code"));
            } else {
              App.error_msg(context,
                  App_Localization.of(context).translate("err_resend_code"));
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            verify(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
}
