import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/login_controller.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/forgot_password.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/signup.dart';

class LogIn extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("login")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loginController.fake.value ? Center() : Center(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          onChanged: (query) {
                            loginController.fake.value = false;
                          },
                          controller: loginController.email,
                          decoration: InputDecoration(
                              label: Text(
                                App_Localization.of(context).translate("email"),
                                style: TextStyle(fontSize: 13),
                              ),
                              errorText: loginController.validate.value &&
                                      loginController.email.text.isEmpty
                                  ? App_Localization.of(context)
                                      .translate("email_required")
                                  : null),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          onChanged: (query) {
                            loginController.fake.value = true;
                          },
                          controller: loginController.password,
                          obscureText: loginController.hide.value,
                          decoration: InputDecoration(
                              isCollapsed: true,
                              suffix: IconButton(
                                  onPressed: () {
                                    loginController.hide.value =
                                        !loginController.hide.value;
                                  },
                                  icon: Icon(
                                      loginController.hide.value
                                          ? Icons.visibility_off
                                          : Icons.visibility_sharp,
                                      color: Colors.blue)),
                              label: Text(
                                App_Localization.of(context)
                                    .translate("password"),
                                style: TextStyle(fontSize: 13),
                              ),
                              errorText: loginController.validate.value &&
                                      loginController.password.text.isEmpty
                                  ? App_Localization.of(context)
                                      .translate("password_required")
                                  : null),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgotPassword());
                              },
                              child: Text(
                                App_Localization.of(context)
                                    .translate("forgot_password"),
                                style:
                                    TextStyle(color: App.primery, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          loginController.login(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          decoration: BoxDecoration(
                              color: App.primery,
                              gradient: App.linearGradient,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              App_Localization.of(context).translate("login"),
                              style: TextStyle(
                                  color: App.secondry,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Home());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          decoration: BoxDecoration(
                              color: App.primery,
                              gradient: App.linearGradient,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              App_Localization.of(context)
                                  .translate("visit_as_guest"),
                              style: TextStyle(
                                  color: App.secondry,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            App_Localization.of(context)
                                .translate("do_have_account"),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            loginController.loading.value
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
        ),
      ),
    );
  }
}
