import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/helper/store.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/no_internet.dart';
import 'package:brakly_mobile/view/order_type.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.find();

  Rx<bool> validate = false.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> hide = true.obs;

  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController state = TextEditingController();
  String phonePref = "+971";
  String ISO_code = "AE";
  String country = "United Arab Emirates (AE)";

  submit() {
    validate.value = true;
    if (email.text.isNotEmpty &&
        first_name.text.isNotEmpty &&
        last_name.text.isNotEmpty &&
        address1.text.isNotEmpty &&
        address2.text.isNotEmpty &&
        apartment.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        state.text.isNotEmpty &&
        country.isNotEmpty) {
      Store.saveAddress(email.text, address1.text, address2.text,
          apartment.text, phone.text, country, state.text, phonePref, ISO_code);
      Get.to(() => OrderType());
    }
  }

  addOrder(BuildContext context, int is_paid) {
    loading.value = true;
    API.checkInternet().then((value) async {
      if (value) {
        API
            .addOrder(
                first_name.text,
                last_name.text,
                address1.text,
                address2.text,
                phonePref + phone.text,
                country,
                state.text,
                cartController.total.value,
                cartController.subTotal.value,
                cartController.shipping.value,
                cartController.coupon.value,
                is_paid,
                cartController.cart.value)
            .then((value) {
          loading.value = false;
          if (value) {
            cartController.clear();
            App.sucss_msg(context,
                App_Localization.of(context).translate("place_order_succ"));
            Get.offAll(() => Home());
          } else {
            App.error_msg(
                context, App_Localization.of(context).translate("oops"));
          }
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          addOrder(context, is_paid);
        });
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }
}
