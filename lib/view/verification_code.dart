import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/verification_code_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/signup.dart';

class VerificationCode extends StatelessWidget {
  VerificationCodeController verificationCodeController =
      Get.put(VerificationCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("verificaton_code")),
        centerTitle: true,
      ),
      body: Obx(() {
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          onChanged: (query) {
                            verificationCodeController.fake.value = true;
                          },
                          controller: verificationCodeController.code,
                          decoration: InputDecoration(
                              label: Text(
                                App_Localization.of(context).translate("code"),
                                style: TextStyle(fontSize: 13),
                              ),
                              errorText:
                                  verificationCodeController.validate.value &&
                                          verificationCodeController
                                              .code.text.isEmpty
                                      ? App_Localization.of(context)
                                          .translate("code_required")
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
                                verificationCodeController.resend(context);
                              },
                              child: Text(
                                App_Localization.of(context)
                                    .translate("resend"),
                                style: TextStyle(
                                    color: App.primery,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
                                    .translate("your_email_is") +
                                " " +
                                API.email +
                                " ",
                            style: TextStyle(fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(() => SignUp());
                            },
                            child: Text(
                              App_Localization.of(context).translate("or_edit"),
                              style: TextStyle(
                                  color: App.primery,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          verificationCodeController.verify(context);
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
                              App_Localization.of(context).translate("submit"),
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
                          Get.offAll(() => Home());
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
                    ],
                  ),
                ),
              ),
              verificationCodeController.loading.value
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
        );
      }),
    );
  }
}
