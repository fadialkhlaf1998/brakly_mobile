import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/controller/posts_list_controller.dart';
import 'package:brakly_mobile/controller/wishlist_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';

class PostList extends StatelessWidget {
  HomeController homeController = Get.find();
  CartController cartController = Get.find();
  WishListController wishListController = Get.find();
  PostListController postListController = Get.find();

  PostList();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(App_Localization.of(context).translate("posts_list")),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: postListController.posts.value.isNotEmpty
                    ? Grid_vertical(count:2,ratio:1,posts:postListController.posts.value,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,op: 1)
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(App_Localization.of(context)
                                  .translate("no_elements"))),
                        ),
                      ),
              ),
            ),
            postListController.loading.value
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
          ],
        ),
      );
    });
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
                    if (posts[index].postTypeId == API.product) {
                      homeController.doFunction(0, posts[index].id, context);
                    } else {
                      homeController.doFunction(op, posts[index].id, context);
                    }
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
                        posts[index].postTypeId == API.product &&
                                posts[index].price != null
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
                            : Center(),
                        posts[index].postTypeId == API.product
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
                posts[index].postTypeId == API.product
                    ? Positioned(child: Obx(() {
                        return IconButton(
                          onPressed: () {
                            wishListController.wishlistFunction(
                                posts[index], context);
                          },
                          icon: Icon(
                            posts[index].favorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: App.primery,
                          ),
                        );
                      }))
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
                  if (posts[index].postTypeId == API.product) {
                    homeController.doFunction(0, posts[index].id, context);
                  } else {
                    homeController.doFunction(op, posts[index].id, context);
                  }
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
                      posts[index].postTypeId == API.product &&
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
                      posts[index].postTypeId == API.product
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
              posts[index].postTypeId == API.product
                  ? Positioned(child: Obx(() {
                      return IconButton(
                        onPressed: () {
                          wishListController.wishlistFunction(
                              posts[index], context);
                        },
                        icon: Icon(
                          posts[index].favorite.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: App.primery,
                        ),
                      );
                    }))
                  : Center()
            ],
          );
        });
  }
}
