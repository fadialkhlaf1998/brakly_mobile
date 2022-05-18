import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/cart.dart';
import 'package:brakly_mobile/view/profile.dart';
import 'package:brakly_mobile/view/wishlist.dart';

class Home extends StatelessWidget {
  HomeController homeController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.btmNavBarIndex.value == 0
          ? home(context)
          : homeController.btmNavBarIndex.value == 1
              ? WishList()
              : homeController.btmNavBarIndex.value == 2
                  ? Cart()
                  : Profile();
    });
  }

  home(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        centerTitle: true,
      ),
      bottomNavigationBar: App.bottomNavBar(
          context, homeController, cartController.cart.value.length),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Grid_horizantel(count:1,ratio:0.6666666666666666,posts:homeController.main_posts[0],height:MediaQuery.of(context).size.height*0.22,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,op: 1),SizedBox(height: 5,),
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
  }

  Grid_horizantel(
      {required int count,
      required double ratio,
      required List<Post> posts,
      required double height,
      required double? img_radius,
      required double? radius,
      required bool circle,
      required Color background,
      required bool shadow,
      required int op}) {
    return Container(
      height: height,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: ratio),
          scrollDirection: Axis.horizontal,
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
                                            .replaceAll(
                                                "localhost", "10.0.2.2")),
                                        fit: BoxFit.cover)),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(child: Text(posts[index].title!)),
                            )),
                        API.product == posts[index].postTypeId
                            ? posts[index].price != null
                                ? Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                              posts[index].price!.toString() +
                                                  " " +
                                                  App_Localization.of(context)
                                                      .translate("aed"))),
                                    ))
                                : Center()
                            : Center(),
                        API.product == posts[index].postTypeId
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    //todo add to cart
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
                API.product == posts[index].postTypeId
                    ? Positioned(
                        child: IconButton(
                        onPressed: () {
                          //todo add to wishlist
                        },
                        icon: Icon(
                          posts[index].wishlist == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: App.primery,
                        ),
                      ))
                    : Center()
              ],
            );
          }),
    );
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
                      API.product == posts[index].postTypeId
                          ? posts[index].price != null
                              ? Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                            posts[index].price!.toString() +
                                                " " +
                                                App_Localization.of(context)
                                                    .translate("aed"))),
                                  ))
                              : Center()
                          : Center(),
                      API.product == posts[index].postTypeId
                          ? Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  //todo add to cart
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
              API.product == posts[index].postTypeId
                  ? Positioned(
                      child: IconButton(
                      onPressed: () {
                        //todo add to wishlist
                      },
                      icon: Icon(
                        posts[index].wishlist == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: App.primery,
                      ),
                    ))
                  : Center()
            ],
          );
        });
  }
}
