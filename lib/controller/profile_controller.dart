import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/customer_order.dart';
import 'package:brakly_mobile/view/no_internet.dart';

class ProfileController extends GetxController {
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;

  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      loading.value = true;
      API.checkInternet().then((value) async {
        if (value) {
          API.upload_customer_photo(image.path).then((value) {
            API.login().then((value) {
              loading.value = false;
            });
          });
        } else {
          Get.to(() => NoInternet())!;
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }

  deleteAccount(BuildContext context) {
    loading.value = true;
    API.checkInternet().then((value) async {
      if (value) {
        API.delete_account().then((value) {
          loading.value = false;
          if (!value) {
            App.error_msg(
                context, App_Localization.of(context).translate("oops"));
          }
        });
      } else {
        Get.to(() => NoInternet())!;
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }

  getMyOrder(BuildContext context) {
    loading.value = true;
    API.checkInternet().then((value) async {
      if (value) {
        API.customerOrder().then((value) {
          loading.value = false;
          if (value.isNotEmpty) {
            Get.to(() => CustomerOrderView(value));
          } else {
            App.error_msg(context,
                App_Localization.of(context).translate("donot_have_order_yet"));
          }
        });
      } else {
        Get.to(() => NoInternet())!;
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }
}
