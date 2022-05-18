import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/login.dart';

class ProductInfoController extends GetxController {
  Post? post;
  var loading = false.obs;
  var selected_slider = 0.obs;
  var counter = 1.obs;
  TextEditingController review = TextEditingController();

  increase() {
    if (counter < post!.availability!) {
      counter++;
    }
  }

  decrease() {
    if (counter > 1) {
      counter--;
    }
  }

  addReview(BuildContext context) async {
    if (API.customer == null) {
      Get.to(() => LogIn());
    } else if (review.text.isEmpty) {
      App.error_msg(context, App_Localization.of(context).translate("oops"));
    } else {
      loading.value = true;
      bool add = await API.addReview(post!.id, review.text);

      if (add) {
        post!.review!.insert(
            0,
            Review(
                id: -1,
                postId: post!.id,
                customerId: API.customer_id,
                body: review.text,
                rate: post!.my_rate == null ? 0 : post!.my_rate!.round(),
                firstname: API.customer!.firstname,
                lastname: API.customer!.lastname));
        App.sucss_msg(
            context, App_Localization.of(context).translate("succ_review"));
        loading.value = false;
        review.clear();
      } else {
        App.error_msg(context, App_Localization.of(context).translate("oops"));
        loading.value = false;
        review.clear();
      }
    }
  }
}
