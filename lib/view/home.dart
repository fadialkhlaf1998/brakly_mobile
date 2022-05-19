import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("FREE PET PICK UP - BOOK TODAY", style: TextStyle(fontSize: 15),),
      //   backgroundColor: Colors.black,
      //   centerTitle: true,
      // ),
      endDrawer: _drawer(context),
      bottomNavigationBar: App.bottomNavBar(
          context, homeController, cartController.cart.value.length),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 25),
                _header(context),
                const SizedBox(height: 25),
                _slider(context),
                const SizedBox(height: 50),
                _services(context),
                const SizedBox(height: 40),
                _aboutInfoPage(context),
                _product(context),
                _brands(context),
                _footer(context),
                _footer1(context)
              ],
            ),
          ),
        ),
      ),
    );
  }



  _header(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                color: Colors.white,
                child: Image.asset('assets/logo.png', fit: BoxFit.fill,),
              ),
              Bounce(
                onPressed: (){

                },
                duration: Duration(milliseconds: 90),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 50,
                  decoration: BoxDecoration(
                      color: App.primery,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.phone, color: Colors.white),
                        SizedBox(width: 5),
                        Text('Book now', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context)=>Center(
                  child: GestureDetector(
                    onTap: () =>  Scaffold.of(context).openEndDrawer(),
                    child: const Icon(Icons.menu,size: 35,),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: (){
              //     Scaffold.of(context).openDrawer();
              //   },
              //   child: Icon(Icons.menu,size: 35,),
              // ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            height: 65,
            child: Row(
              children: [
                 const Flexible(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)
                        )
                      )
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: App.primery,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        topRight:  Radius.circular(40),
                      )
                  ),
                    child: Center(
                      child: Icon(Icons.search,color: Colors.white,size: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _slider(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          height: MediaQuery.of(context).size.height * 0.35,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: homeController.banner.map((i){
          return Builder(
            builder: (BuildContext context){
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.network(i.image ?? "", fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      i.title ?? "",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _services(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 5,
          childAspectRatio: 0.8,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeController.service.length,
        itemBuilder: (context,index){
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(homeController.service[index].image ?? "",fit: BoxFit.cover,),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      homeController.service[index].title ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: App.primery,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Center(
                        child: Text('Book now',style: TextStyle(color: Colors.white, fontSize: 18,),),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _aboutInfoPage(context){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.18,
          color: App.primery,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              homeController.aboutHomePage!.subTitle.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.network(homeController.aboutHomePage!.image ?? "", fit: BoxFit.cover,),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
          child: Center(
            child: Text(
              homeController.aboutHomePage!.stringDescription.toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  _product(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: App.grey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
              'OUR PET\'S CHOICE',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: App.primery),
          ),
          SizedBox(height: 40),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeController.product.length,
            itemBuilder: (context, index){
              return Container(
                margin: EdgeInsets.only(bottom: 30),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Image.network(homeController.product[index].image ?? "",fit: BoxFit.contain,),
                    ),
                    Text(
                        homeController.product[index].title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                    ),
                    Divider(indent: 170,endIndent: 170,thickness: 1,color: Colors.black.withOpacity(0.5),),
                    Text(
                      homeController.product[index].price.toString() + ' AED',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: Text('1', ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      color: Colors.black,
                      child: Center(
                        child: Text('Add to cart', style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 55,
            decoration: BoxDecoration(
              color: App.primery,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text('All items',style: TextStyle(color: Colors.white, fontSize: 17),),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  _brands(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: App.grey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
                'BEST BRANDS AT LOWEST PRICES',
              textAlign: TextAlign.center,
              style: TextStyle(color: App.primery, fontSize: 25,fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.brands.length,
              itemBuilder: (context, index){
                return Container(
                  child: Image.network(homeController.brands[index].image ?? "",fit: BoxFit.contain,),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _footer(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: App.green,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      'The Barkley Pet Camp',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      'Info',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                      'Get Special Deals & Offers',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Email Address'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            color: Colors.white,
            child: Center(
              child: Text('Become Our Friend!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            color: Colors.black,
            child: Center(
              child: Text('Subscribe',style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/face.svg'),
                SvgPicture.asset('assets/insta.svg'),
                SvgPicture.asset('assets/teitter.svg'),
                SvgPicture.asset('assets/in.svg'),
              ],
            ),
          )
        ],
      ),
    );
  }

  _footer1(context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Center(
        child: Text('©2022 by The Barkley Pet Camp',style: TextStyle(fontSize: 13),),
      ),
    );
  }


  _drawer(context){
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: Text('HOME'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: Text('ABOUT'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: Text('GALLERY'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.transparent,
            child: Center(
              child: Text('CONTACT'),
            ),
          ),
        ],
      ),
    );
  }


  // Stack(
  // children: [
  // SingleChildScrollView(
  // child: Column(
  // children: [
  // Grid_horizantel(count:1,ratio:0.6666666666666666,posts:homeController.main_posts[0],height:MediaQuery.of(context).size.height*0.22,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,op: 1),SizedBox(height: 5,),
  // ],
  // ),
  // ),
  // homeController.loading.value
  // ? Positioned(
  // child: Container(
  // width: MediaQuery.of(context).size.width,
  // height: MediaQuery.of(context).size.height,
  // color: App.primery.withOpacity(0.5),
  // child: Center(
  // child: CircularProgressIndicator(),
  // ),
  // ))
  //     : Center()
  // ],
  // ),

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
