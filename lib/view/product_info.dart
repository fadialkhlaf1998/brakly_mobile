import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/product_info_controller.dart';
import 'package:brakly_mobile/controller/wishlist_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/image_show.dart';

class ProductInfo extends StatelessWidget {
  ProductInfoController productInfoController = Get.find();
  WishListController wishListController = Get.find();
  CartController cartController = Get.find();

  ProductInfo() {
    productInfoController.counter.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("product_info")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: productInfoController.post == null
                    ? Center()
                    : Column(
                        children: [
                          _slider(context),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                _titlePriceRateAvailability(context),
                                _desc(context),
                                _addToCart(context),
                                _addToRate(context),
                                _addReview(context),
                                _reviews(context),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
              productInfoController.loading.value
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

  _slider(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                boxShadow: [App.boxShadow]),
            /**slider*/
            child: CarouselSlider(
              items: productInfoController.post!.media!.map((e) {
                return GestureDetector(
                  onTap: () {
                    print('************');
                    Get.to(() => ImageShow(e.link));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                e.link.replaceAll("localhost", "10.0.2.2")),
                            fit: BoxFit.contain)),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: productInfoController.post!.media!.length > 1
                    ? true
                    : false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.0,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  productInfoController.selected_slider.value = index;
                },
              ),
            ),
          ),
        ),
        /**3 point*/
        Positioned(
          top: MediaQuery.of(context).size.height * 0.35,
          left: 20,
          right: 20,
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: productInfoController.post!.media!.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: productInfoController.selected_slider.value ==
                              productInfoController.post!.media!.indexOf(e)
                          ? App.primery
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        /**header row*/
        Positioned(
          left: 10,
          top: 10,
          child: Container(
              width: MediaQuery.of(context).size.width - 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(onPressed: (){
                  //   Get.back();
                  // }, icon: Icon(Icons.arrow_back_ios,color: App.primery,)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //
                  //   ],
                  // ),
                  IconButton(
                      onPressed: () {
                        wishListController.wishlistFunction(
                            productInfoController.post!, context);
                      },
                      icon: Icon(
                        productInfoController.post!.favorite.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: App.primery,
                      ))
                ],
              )),
        )
      ],
    );
  }

  _titlePriceRateAvailability(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              productInfoController.post!.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productInfoController.post!.price!.toString() +
                  " " +
                  App_Localization.of(context).translate("aed"),
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: App.primery, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      productInfoController.post!.rate!.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        overflow: TextOverflow.clip,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              App_Localization.of(context).translate("availability") +
                  ": " +
                  productInfoController.post!.availability!.toStringAsFixed(0),
            ),
          ],
        ),
      ],
    );
  }

  _desc(BuildContext context) {
    return Html(data: productInfoController.post!.stringDescription);
  }

  _addToCart(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            cartController.addToCart(productInfoController.post!,
                productInfoController.counter.value, context);
          },
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: App.primery, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                App_Localization.of(context).translate("add_to_cart"),
                style: TextStyle(color: App.secondry),
              ),
            ),
          ),
        ),
        Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        productInfoController.decrease();
                      },
                      icon: Icon(
                        Icons.remove,
                      )),
                  Text(productInfoController.counter.toString()),
                  IconButton(
                      onPressed: () {
                        productInfoController.increase();
                      },
                      icon: Icon(
                        Icons.add,
                      )),
                ],
              ),
            ))
      ],
    );
  }

  _addToRate(BuildContext context) {
    return Column(
      children: [
        Text(App_Localization.of(context).translate("add_your_rate"),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: productInfoController.post!.my_rate!,
              minRating: 1,
              direction: Axis.horizontal,
              // ignoreGestures: true,
              itemSize: 35,
              // allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: App.primery,
              ),
              onRatingUpdate: (rating) {
                // MyProduct myProduct1 = MyProduct(id: myProduct.id, subCategoryId: myProduct.subCategoryId, brandId: myProduct.brandId, title: myProduct.title, subTitle: myProduct.subTitle, description: myProduct.description, price: myProduct.price, rate: myProduct.rate, image: myProduct.image, ratingCount: myProduct.ratingCount,availability: myProduct.availability,offer_price: myProduct.offer_price);
                // wishListController.add_to_rate(myProduct1, rating);
                // MyApi.rate(productController.myProduct!, rating);
                print(rating);
                // print(int.parse(rating.toString()));
                API.addRate(productInfoController.post!.id, rating.round());
              },
            )
          ],
        ),
      ],
    );
  }

  _addReview(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7 - 10,
          height: 50,
          child: TextField(
            onChanged: (query) {
              // loginController.fake.value=false;
            },
            controller: productInfoController.review,
            decoration: InputDecoration(
              label: Text(
                App_Localization.of(context).translate("review"),
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            productInfoController.addReview(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3 - 10,
            height: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(App_Localization.of(context).translate("post"),
                  style: TextStyle(color: App.primery)),
            ),
          ),
        )
      ],
    );
  }

  _reviews(BuildContext context) {
    return Container(
      // height: 2000,
      child: ListView.builder(
          itemCount: productInfoController.post!.review!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productInfoController.post!.review![index].firstname +
                          " " +
                          productInfoController.post!.review![index].lastname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(productInfoController.post!.review![index].body),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
