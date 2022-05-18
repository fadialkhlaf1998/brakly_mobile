import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/main.dart';
import 'package:brakly_mobile/model/address.dart';
import 'package:brakly_mobile/model/line_item.dart';
import 'package:brakly_mobile/model/login_info.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/login.dart';

class Store {
  static saveLanguage(String lang) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("language", lang);
    });
  }

  static changeLanguage(BuildContext context, String lang) {
    Global.language = lang;
    Locale locale = Locale(lang);
    MyApp.set_locale(context, locale);
    saveLanguage(lang);
  }

  static Future<String> loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString("language") ?? "en";
    Global.language = lang;
    return lang;
  }

  static saveLogInInfo(String email, String password) {
    SharedPreferences.getInstance().then((prefs) {
      LogInInfo loginInfo = LogInInfo(email: email, password: password);
      prefs.setString("loginInfo", loginInfo.toJson());
    });
  }

  static Future<LogInInfo?> loadLogInInfo() async {
    var prefs = await SharedPreferences.getInstance();
    LogInInfo? loginInfo = prefs.getString("loginInfo") == null
        ? null
        : LogInInfo.fromJson(prefs.getString("loginInfo")!);
    if (loginInfo != null) {
      API.email = loginInfo.email;
      API.password = loginInfo.password;
    }
    return loginInfo;
  }

  static Future<bool> isActive() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("active") ?? false;
  }

  static saveActive(bool val) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setBool("active", val);
  }

  static saveCart(List<LineItem> cart) {
    SharedPreferences.getInstance().then((prefs) {
      LineItemDecoder lineItemDecoder = LineItemDecoder(cart: cart);
      prefs.setString("cart", lineItemDecoder.toJson());
    });
  }

  static Future<List<LineItem>> loadCart() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("cart") ?? "non";
    if (data != "non") {
      List<LineItem> cart = LineItemDecoder.fromJson(data).cart;
      List<int> ids = <int>[];
      for (int i = 0; i < cart.length; i++) {
        ids.add(cart[i].post.id);
      }

      List<Post> posts = await API.restoreCart(ids);
      for (int i = 0; i < cart.length; i++) {
        for (int j = 0; j < posts.length; j++) {
          if (posts[j].id == cart[i].post.id) {
            cart[i].post = posts[j];
          }
        }
      }
      return cart;
    } else {
      return <LineItem>[];
    }
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("active");
    prefs.remove("loginInfo");
    API.is_active = false;
    API.email = "";
    API.password = "";
    API.customer_id = -1;
    Get.to(() => LogIn());
  }

  static saveAddress(
      String email,
      String address1,
      String address2,
      String apartment,
      String phone,
      String country,
      String state,
      String phone_pref,
      String ISO_code) async {
    var prefs = await SharedPreferences.getInstance();
    API.address = Address(
        email: email,
        address1: address1,
        address2: address2,
        apartment: apartment,
        phone: phone,
        country: country,
        state: state,
        phone_pref: phone_pref,
        ISO_code: ISO_code);
    prefs.setString("address", API.address!.toJson());
  }

  static Future<Address?> loadAddress() async {
    var prefs = await SharedPreferences.getInstance();
    String data = prefs.getString("address") ?? "non";
    if (data == "non") {
      return null;
    } else {
      return Address.fromJson(data);
    }
  }
}
