import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/helper/global.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class App {
  static Color primery = Color(0xfffc7012);
  static Color secondry = Color(0xffffffff);
  static Color grey = Color(0xfff5f5f5);
  static Color green = Color(0xffa0c769);
  static Color lightOrang = Color(0xffFFB380);
  static Color auto = Colors.black.withOpacity(0.75);
  static BoxShadow boxShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.9),
      spreadRadius: 0.1,
      blurRadius: 5,
      offset: Offset(3, 2));
  static BoxShadow noShadow = BoxShadow(
      color: Colors.grey.withOpacity(0),
      spreadRadius: 0.1,
      blurRadius: 5,
      offset: Offset(3, 2));

  static LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      App.primery,
      App.primery.withOpacity(0.8),
    ],
  );

  static bottomNavBar(
      BuildContext context, HomeController homeController, int count) {
    return Stack(
      children: [
        BottomNavigationBar(
            currentIndex: homeController.btmNavBarIndex.value,
            onTap: (int index) {
              homeController.btmNavBarIndex.value = index;
            },
            backgroundColor: App.primery,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            iconSize: 25,
            selectedItemColor: Colors.black.withOpacity(0.5),
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "",
              ),
            ]),
        Positioned(
            top: 2,
            right: Global.language == "en"
                ? (MediaQuery.of(context).size.width / 4 +
                        MediaQuery.of(context).size.width / 8) +
                    5
                : null,
            left: Global.language == "ar"
                ? (MediaQuery.of(context).size.width / 4 +
                        MediaQuery.of(context).size.width / 8) +
                    5
                : null,
            child: count == 0
                ? Center()
                : Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Center(
                        child: Text(
                      count.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )),
                  )),
      ],
    );
  }

  static sucss_msg(BuildContext context, String msg) {
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: msg,
        backgroundColor: primery,
      ),
    );
  }

  static error_msg(BuildContext context, String err) {
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: err,
      ),
    );
  }

  static Grid_horizantel(
      {required int count,
      required double ratio,
      required List<Post> posts,
      required double height,
      required double? img_radius,
      required double? radius,
      required bool circle,
      required Color background,
      required bool shadow}) {
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
            return GestureDetector(
              onTap: () {
                //todo api
              },
              child: Column(
                children: [
                  Container(
                    height: height - 5,
                    decoration: BoxDecoration(
                        borderRadius: radius == null
                            ? null
                            : BorderRadius.circular(radius),
                        color: background,
                        boxShadow: [shadow ? boxShadow : noShadow]),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
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
                                      fit: BoxFit.fill)),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(child: Text(posts[index].title!)),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  static Grid_vertical(
      {required int count,
      required double ratio,
      required List<Post> posts,
      required double? img_radius,
      required double? radius,
      required bool circle,
      required Color background,
      required bool shadow}) {
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
          return GestureDetector(
            onTap: () {
              //todo api
            },
            child: Container(
              decoration: BoxDecoration(
                color: background,
                boxShadow: [shadow ? boxShadow : noShadow],
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
                              shape:
                                  circle ? BoxShape.circle : BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(posts[index]
                                      .image!
                                      .replaceAll("localhost", "10.0.2.2")),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(child: Text(posts[index].title!)),
                      )),
                ],
              ),
            ),
          );
        });
  }

  static String translate(BuildContext context, String key) {
    return App_Localization.of(context).translate(key);
  }
}
