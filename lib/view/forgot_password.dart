import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/forgot_password.dart';
import 'package:brakly_mobile/helper/app.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("forgot_password")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      forgotPasswordController.fake.value ? Center() : Center(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          onChanged: (query) {
                            forgotPasswordController.fake.value = false;
                          },
                          controller: forgotPasswordController.email,
                          decoration: InputDecoration(
                              label: Text(
                                App_Localization.of(context).translate("email"),
                                style: TextStyle(fontSize: 13),
                              ),
                              errorText:
                                  forgotPasswordController.validate.value &&
                                          forgotPasswordController
                                              .email.text.isEmpty
                                      ? App_Localization.of(context)
                                          .translate("email_required")
                                      : null),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          forgotPasswordController.submit(context);
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
                    ],
                  ),
                );
              }),
            ),
            forgotPasswordController.loading.value
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
