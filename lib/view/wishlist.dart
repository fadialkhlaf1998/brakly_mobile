import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/controller/wishlist_controller.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';

class WishList extends StatelessWidget {
  HomeController homeController = Get.find();
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(App_Localization.of(context).translate("wishlist")),
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
                      SizedBox(height: 5,),wishListController.wishlist.value.isNotEmpty?Grid_vertical(count:2,ratio:1,posts:wishListController.wishlist.value,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,cart: true,op: 0) :isEmpty(context),
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
                    : Center()
              ],
            ),
          ),
        ),
      );
    });
  }

  Grid_vertical(
      {required int count,
      required double ratio,
      required List<Post> posts,
      required double? img_radius,
      required double? radius,
      required bool circle,
      required Color background,
      required bool shadow,
      required bool cart,
      required int op}) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: ratio),
        physics: NeverScrollableScrollPhysics(),
        itemCount: posts.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  homeController.doFunction(op, posts[index].id, context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: background,
                    boxShadow: [shadow ? App.boxShadow : App.noShadow],
                    borderRadius:
                        radius == null ? null : BorderRadius.circular(radius),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
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
                                      image: NetworkImage(posts[index]
                                          .image!
                                          .replaceAll("localhost", "10.0.2.2")),
                                      fit: BoxFit.cover)),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Center(child: Text(posts[index].title!)),
                          )),
                      posts[index].price != null
                          ? Expanded(
                              flex: 1,
                              child: Container(
                                child: Center(
                                    child: Text(posts[index].price!.toString() +
                                        " " +
                                        App_Localization.of(context)
                                            .translate("aed"))),
                              ))
                          : Center(),
                      cart
                          ? Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  cartController.addToCart(
                                      posts[index], 1, context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width /
                                      (count + 1),
                                  decoration: BoxDecoration(
                                      color: App.primery,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(App_Localization.of(context)
                                          .translate("add_to_cart"))),
                                ),
                              ))
                          : Center(),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: IconButton(
                onPressed: () {
                  wishListController.deleteFromWishlist(posts[index]);
                },
                icon: Icon(
                  Icons.delete,
                  color: App.primery,
                ),
              ))
            ],
          );
        });
  }

  isEmpty(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
        children: [
          Icon(
            Icons.favorite_border,
            color: App.primery,
            size: 35,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            App_Localization.of(context).translate('dont_have_wishlist'),
            style: TextStyle(
                color: App.primery, fontSize: 13, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              homeController.btmNavBarIndex.value = 0;
            },
            child: Container(
              width: 120,
              height: 40,
              color: App.primery,
              child: Center(
                child: Text(
                  App_Localization.of(context).translate('start_shopping'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
