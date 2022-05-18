import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/change_password_controller.dart';
import 'package:brakly_mobile/helper/app.dart';

class ChangePassword extends StatelessWidget {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("change_password")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    changePasswordController.fake.value ? Center() : Center(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        onChanged: (query) {
                          changePasswordController.fake.value = true;
                        },
                        obscureText: changePasswordController.hide1.value,
                        controller: changePasswordController.oldPassword,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            suffix: IconButton(
                                onPressed: () {
                                  changePasswordController.hide1.value =
                                      !changePasswordController.hide1.value;
                                },
                                icon: Icon(
                                  changePasswordController.hide1.value
                                      ? Icons.visibility_off
                                      : Icons.visibility_sharp,
                                  color: Colors.blue,
                                )),
                            label: Text(
                              App_Localization.of(context)
                                  .translate("old_password"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText:
                                changePasswordController.validate.value &&
                                        changePasswordController
                                            .oldPassword.text.isEmpty
                                    ? App_Localization.of(context)
                                        .translate("old_password_required")
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
                          changePasswordController.fake.value = true;
                        },
                        controller: changePasswordController.newPassword,
                        obscureText: changePasswordController.hide2.value,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            suffix: IconButton(
                                onPressed: () {
                                  changePasswordController.hide2.value =
                                      !changePasswordController.hide2.value;
                                },
                                icon: Icon(
                                  changePasswordController.hide2.value
                                      ? Icons.visibility_off
                                      : Icons.visibility_sharp,
                                  color: Colors.blue,
                                )),
                            label: Text(
                              App_Localization.of(context)
                                  .translate("new_password"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText:
                                changePasswordController.validate.value &&
                                        changePasswordController
                                            .newPassword.text.isEmpty
                                    ? App_Localization.of(context)
                                        .translate("new_password_required")
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
                          changePasswordController.fake.value = true;
                        },
                        controller: changePasswordController.confirmPassword,
                        obscureText: changePasswordController.hide3.value,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            suffix: IconButton(
                                onPressed: () {
                                  changePasswordController.hide3.value =
                                      !changePasswordController.hide3.value;
                                },
                                icon: Icon(
                                  changePasswordController.hide3.value
                                      ? Icons.visibility_off
                                      : Icons.visibility_sharp,
                                  color: Colors.blue,
                                )),
                            label: Text(
                              App_Localization.of(context)
                                  .translate("confirm_password"),
                              style: TextStyle(fontSize: 13),
                            ),
                            errorText:
                                changePasswordController.validate.value &&
                                        changePasswordController
                                            .confirmPassword.text.isEmpty
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
                        changePasswordController.submit(context);
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
                  ],
                ),
              ),
              changePasswordController.loading.value
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
