import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/controller/profile_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/helper/store.dart';
import 'package:brakly_mobile/view/change_password.dart';
import 'package:brakly_mobile/view/login.dart';
import 'package:brakly_mobile/view/signup.dart';

class Profile extends StatelessWidget {
  HomeController homeController = Get.find();
  CartController cartController = Get.find();
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("profile")),
        centerTitle: true,
      ),
      bottomNavigationBar: App.bottomNavBar(
          context, homeController, cartController.cart.value.length),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.85,
          child: API.customer_id == -1 ? notLogin(context) : login(context),
        ),
      ),
    );
  }

  notLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(App_Localization.of(context).translate("you_donot_have_account")),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => LogIn());
              },
              child: Text(
                App_Localization.of(context).translate("login"),
                style: TextStyle(
                  color: App.primery,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(App_Localization.of(context).translate("or")),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => SignUp());
              },
              child: Text(
                App_Localization.of(context).translate("sign_up"),
                style: TextStyle(
                  color: App.primery,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  login(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileController.fake.value ? Center() : Center(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    child: API.customer!.image.length == 0
                                        ? Icon(
                                            Icons.person,
                                            size: 65,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(API
                                                            .media_url +
                                                        API.customer!.image),
                                                    fit: BoxFit.cover)),
                                          )),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                                onPressed: () {
                                  profileController.pickImage();
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: App.primery,
                                )))
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              App_Localization.of(context).translate("hello") +
                                  ", ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              API.customer!.firstname,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              API.customer!.lastname,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              App_Localization.of(context).translate("email") +
                                  ": ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              API.customer!.email,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    profileController.getMyOrder(context);
                  },
                  autofocus: true,
                  title:
                      Text(App_Localization.of(context).translate("my_orders")),
                  subtitle: Text(App_Localization.of(context)
                      .translate("my_orders_sub_title")),
                  leading: CircleAvatar(
                    child: Icon(Icons.language),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  autofocus: true,
                  title:
                      Text(App_Localization.of(context).translate("language")),
                  subtitle:
                      Text(Global.language == "en" ? "English" : "العربية"),
                  leading: CircleAvatar(
                    child: Icon(Icons.language),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => ChangePassword());
                  },
                  autofocus: true,
                  title: Text(App_Localization.of(context)
                      .translate("change_password")),
                  subtitle: Text(App_Localization.of(context)
                      .translate("change_password_sub_title")),
                  leading: CircleAvatar(
                    child: Icon(Icons.password),
                  ),
                ),
                ListTile(
                  onTap: () {
                    confirmAlertDialog(context);
                  },
                  autofocus: true,
                  title: Text(
                      App_Localization.of(context).translate("delete_account")),
                  subtitle: Text(App_Localization.of(context)
                      .translate("delete_account_sub_title")),
                  leading: CircleAvatar(
                    child: Icon(Icons.delete),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Store.logout();
                  },
                  autofocus: true,
                  title: Text(App_Localization.of(context).translate("logout")),
                  subtitle: Text(App_Localization.of(context)
                      .translate("logout_sub_title")),
                  leading: CircleAvatar(
                    child: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            profileController.loading.value
                ? Positioned(
                    child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: App.primery.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
                : Center()
          ],
        );
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(App_Localization.of(context).translate("cancel")),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(App_Localization.of(context).translate("language")),
      content: Container(
        height: 65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Store.changeLanguage(context, "en");
                profileController.fake.value = !profileController.fake.value;
                Get.back();
              },
              child: Text("English"),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Store.changeLanguage(context, "ar");
                profileController.fake.value = !profileController.fake.value;
                Get.back();
              },
              child: Text("العربية"),
            )
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  confirmAlertDialog(BuildContext context) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text(App_Localization.of(context).translate("cancel")),
      onPressed: () {
        Get.back();
      },
    );
    Widget okButton = TextButton(
      child: Text(App_Localization.of(context).translate("yes")),
      onPressed: () {
        Get.back();
        profileController.deleteAccount(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(App_Localization.of(context).translate("delete_account")),
      content: Container(
        height: 65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(App_Localization.of(context)
                .translate("are_u_sure_delete_account")),
          ],
        ),
      ),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
