import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_scan_wifi_outlined,
              size: 50,
              color: App.primery,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              child: FittedBox(
                child:
                    Text(App_Localization.of(context).translate("no_internet")),
              ),
            ),
            TextButton(
              onPressed: () {
                API.checkInternet().then((value) {
                  if (value) {
                    Get.back();
                  }
                });
              },
              child: Text(App_Localization.of(context).translate("reload")),
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 14),
                  elevation: 1,
                  backgroundColor: Colors.white),
            )
          ],
        ),
      )),
    );
  }
}
