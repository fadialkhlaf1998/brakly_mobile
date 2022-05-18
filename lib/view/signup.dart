import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/signup_controller.dart';
import 'package:brakly_mobile/helper/app.dart';

class SignUp extends StatelessWidget {
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("sign_up")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    signupController.fake.value ? Center() : Center(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        onChanged: (query) {
                          signupController.fake.value = true;
                        },
                        controller: signupController.firstName,
                        decoration: InputDecoration(
                            label: Text(
                              App_Localization.of(context)
                                  .translate("first_name"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText: signupController.validate.value &&
                                    signupController.firstName.text.isEmpty
                                ? App_Localization.of(context)
                                    .translate("fn_required")
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
                          signupController.fake.value = true;
                        },
                        controller: signupController.lastName,
                        decoration: InputDecoration(
                            label: Text(
                              App_Localization.of(context)
                                  .translate("last_name"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText: signupController.validate.value &&
                                    signupController.lastName.text.isEmpty
                                ? App_Localization.of(context)
                                    .translate("ln_required")
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
                          signupController.fake.value = false;
                        },
                        controller: signupController.email,
                        decoration: InputDecoration(
                            label: Text(
                              App_Localization.of(context).translate("email"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText: signupController.validate.value &&
                                    signupController.email.text.isEmpty
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
                          signupController.fake.value = true;
                        },
                        obscureText: signupController.hide1.value,
                        controller: signupController.password,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            suffix: IconButton(
                                onPressed: () {
                                  signupController.hide1.value =
                                      !signupController.hide1.value;
                                },
                                icon: Icon(
                                  signupController.hide1.value
                                      ? Icons.visibility_off
                                      : Icons.visibility_sharp,
                                  color: Colors.blue,
                                )),
                            label: Text(
                              App_Localization.of(context)
                                  .translate("password"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText: signupController.validate.value &&
                                    signupController.password.text.isEmpty
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
                      child: TextField(
                        onChanged: (query) {
                          signupController.fake.value = true;
                        },
                        controller: signupController.confirm_password,
                        obscureText: signupController.hide2.value,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            suffix: IconButton(
                                onPressed: () {
                                  signupController.hide2.value =
                                      !signupController.hide2.value;
                                },
                                icon: Icon(
                                  signupController.hide2.value
                                      ? Icons.visibility_off
                                      : Icons.visibility_sharp,
                                  color: Colors.blue,
                                )),
                            label: Text(
                              App_Localization.of(context)
                                  .translate("confirm_password"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText: signupController.validate.value &&
                                    signupController
                                        .confirm_password.text.isEmpty
                                ? App_Localization.of(context)
                                    .translate("confirm_password_required")
                                : null),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        signupController.signUp(context);
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
                            App_Localization.of(context).translate("sign_up"),
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
                  ],
                ),
              ),
              signupController.loading.value
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
      ),
    );
  }
}
