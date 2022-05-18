import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/checkout_controller.dart';
import 'package:brakly_mobile/helper/app.dart';

class OrderType extends StatelessWidget {
  CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("checkout")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {
                    checkoutController.addOrder(context, 0);
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.local_shipping_outlined),
                  ),
                  title: Text(App_Localization.of(context).translate("cod")),
                  subtitle: Text(
                      App_Localization.of(context).translate("cod_sub_title")),
                )
              ],
            ),
            checkoutController.loading.value
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
