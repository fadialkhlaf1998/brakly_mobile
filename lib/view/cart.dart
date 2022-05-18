import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/controller/wishlist_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/model/line_item.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/checkout.dart';
import 'package:brakly_mobile/view/login.dart';

class Cart extends StatelessWidget {
  HomeController homeController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(App_Localization.of(context).translate("cart")),
          centerTitle: true,
        ),
        bottomNavigationBar: App.bottomNavBar(
            context, homeController, cartController.cart.value.length),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.85,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      cartController.fake.value ? Center() : Center(),
                      SizedBox(
                        height: 5,
                      ),
                      cartController.fake.value?Center():Center(),SizedBox(height: 5,),cartController.cart.value.length>0?cartList(ratio:3,cart:cartController.cart.value,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,op: 0):isEmpty(context),SizedBox(height: cartController.discount.value>0?220:180,),
                    ],
                  ),
                ),
                homeController.loading.value
                    ? Positioned(
                        child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: App.primery.withOpacity(0.5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ))
                    : Center(),
                Positioned(
                  bottom: 0,
                  child: cartController.cart.value.length > 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: cartController.discount.value > 0 ? 220 : 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              linearDashed(
                                  context,
                                  App_Localization.of(context)
                                      .translate("sub_total"),
                                  cartController.subTotal.value.toString()),
                              SizedBox(
                                height: 5,
                              ),
                              linearDashed(
                                  context,
                                  App_Localization.of(context)
                                      .translate("shipping"),
                                  cartController.shipping.value.toString()),
                              SizedBox(
                                height: 5,
                              ),
                              cartController.discount.value > 0
                                  ? linearDashed(
                                      context,
                                      App_Localization.of(context)
                                          .translate("discount"),
                                      (cartController.discount.value)
                                              .toString() +
                                          "%")
                                  : Center(),
                              cartController.discount.value > 0
                                  ? SizedBox(
                                      height: 5,
                                    )
                                  : Center(),
                              cartController.discount.value > 0
                                  ? linearDashed(
                                      context,
                                      App_Localization.of(context)
                                          .translate("coupon"),
                                      cartController.coupon.value.toString())
                                  : Center(),
                              cartController.discount.value > 0
                                  ? SizedBox(
                                      height: 5,
                                    )
                                  : Center(),
                              linearDashed(
                                  context,
                                  App_Localization.of(context)
                                      .translate("total"),
                                  cartController.total.value.toString()),
                              discountTextField(context),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              checkOutBtn(context),
                            ],
                          ),
                        )
                      : Center(),
                ),
                cartController.loading.value
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
        ),
      );
    });
  }

  discountTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              onChanged: (query) {
                // checkoutController.fake.value = !checkoutController.fake.value;
              },
              controller: cartController.discountCode,
              decoration: InputDecoration(
                label: Text(
                  App_Localization.of(context).translate("discount_code"),
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              cartController.activeDiscountCode(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  App_Localization.of(context).translate("apply"),
                  style: TextStyle(color: App.primery),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  cartList(
      {required double ratio,
      required List<LineItem> cart,
      required double? img_radius,
      required double? radius,
      required bool circle,
      required Color background,
      required bool shadow,
      required int op}) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: ratio),
        physics: NeverScrollableScrollPhysics(),
        itemCount: cart.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  homeController.doFunction(op, cart[index].post.id, context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: background,
                    boxShadow: [shadow ? App.boxShadow : App.noShadow],
                    borderRadius:
                        radius == null ? null : BorderRadius.circular(radius),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: img_radius == null
                                      ? null
                                      : BorderRadius.circular(img_radius),
                                  shape: circle
                                      ? BoxShape.circle
                                      : BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage(cart[index]
                                          .post
                                          .image!
                                          .replaceAll("localhost", "10.0.2.2")),
                                      fit: BoxFit.cover)),
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cart[index].post.title!),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cart[index].post.price!.toString() +
                                      " " +
                                      App_Localization.of(context)
                                          .translate("aed")),
                                  Text(cart[index].price.toString() +
                                      " " +
                                      App_Localization.of(context)
                                          .translate("aed")),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  increaseDecrease(context, cart[index].post,
                                      cart[index].count),
                                  IconButton(
                                    onPressed: () {
                                      cartController.removeFromCart(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: App.primery,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  increaseDecrease(BuildContext context, Post post, int count) {
    return Container(
      height: 37.5,
      decoration: BoxDecoration(
          color: App.primery, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.remove,
                color: App.secondry,
              ),
              onPressed: () {
                cartController.decrease(post, -1, context);
              },
            ),
            Text(
              count.toString(),
              style: TextStyle(color: App.secondry),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: App.secondry,
              ),
              onPressed: () {
                cartController.increase(post, 1, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  linearDashed(BuildContext context, String first, String last) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          Text(first),
          SizedBox(
            width: 15,
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final boxWidth = constraints.constrainWidth();
                final dashWidth = 4.0;
                final dashHeight = 2.0;
                final dashCount = (boxWidth / (2 * dashWidth)).floor();
                return Flex(
                  children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    );
                  }),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                );
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(last),
        ],
      ),
    );
  }

  isEmpty(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_shopping_cart_outlined,
                color: App.primery,
                size: 28,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                App_Localization.of(context).translate("dont_have_order"),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                App_Localization.of(context).translate("order_no_data"),
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              GestureDetector(
                  onTap: () {
                    homeController.btmNavBarIndex.value = 0;
                  },
                  child: Text(
                    App_Localization.of(context).translate("start_shopping"),
                    style: TextStyle(
                        color: App.primery, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  checkOutBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (API.customer == null) {
          Get.to(() => LogIn());
        } else {
          if (cartController.cart.isEmpty) {
            App.sucss_msg(
                context, App_Localization.of(context).translate("cart_empty"));
          } else {
            Get.to(() => Checkout());
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 40,
        decoration: BoxDecoration(
            color: App.primery, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(App_Localization.of(context).translate("checkout"),
              style: TextStyle(
                  color: App.secondry,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
