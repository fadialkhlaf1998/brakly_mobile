import 'package:brakly_mobile/view/about.dart';
import 'package:brakly_mobile/view/contact.dart';
import 'package:brakly_mobile/view/gallery.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return  Obx((){
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(App_Localization.of(context).translate("cart")),
        //   centerTitle: true,
        // ),
        // bottomNavigationBar: App.bottomNavBar(
        //     context, homeController, cartController.cart.value.length),
        endDrawer: _drawer(context),

        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    _header(context),
                    _cartList(context),
                    _footer(context),
                    _footer1(context)
                  ],
                ),
              ),
            )
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.85,
          //   child: Stack(
          //     children: [
          //       SingleChildScrollView(
          //         child: Column(
          //           children: [
          //             cartController.fake.value ? Center() : Center(),
          //             SizedBox(
          //               height: 5,
          //             ),
          //             cartController.fake.value?Center():Center(),SizedBox(height: 5,),cartController.cart.value.length>0?cartList(ratio:3,cart:cartController.cart.value,radius:null,circle:false,background: Color(0xffffffff),shadow: false,img_radius: null,op: 0):isEmpty(context),SizedBox(height: cartController.discount.value>0?220:180,),
          //           ],
          //         ),
          //       ),
          //       homeController.loading.value
          //           ? Positioned(
          //               child: Container(
          //               width: MediaQuery.of(context).size.width,
          //               height: MediaQuery.of(context).size.height,
          //               color: App.primery.withOpacity(0.5),
          //               child: Center(
          //                 child: CircularProgressIndicator(),
          //               ),
          //             ))
          //           : Center(),
          //       Positioned(
          //         bottom: 0,
          //         child: true//cartController.cart.value.length > 0
          //             ? Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 height: cartController.discount.value > 0 ? 220 : 180,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(10),
          //                       topRight: Radius.circular(10)),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey.withOpacity(0.5),
          //                       blurRadius: 5,
          //                       spreadRadius: 5,
          //                       offset: Offset(0, 3),
          //                     )
          //                   ],
          //                 ),
          //                 child: Column(
          //                   children: [
          //                     SizedBox(
          //                       height: 5,
          //                     ),
          //                     linearDashed(
          //                         context,
          //                         App_Localization.of(context)
          //                             .translate("sub_total"),
          //                         cartController.subTotal.value.toString()),
          //                     SizedBox(
          //                       height: 5,
          //                     ),
          //                     linearDashed(
          //                         context,
          //                         App_Localization.of(context)
          //                             .translate("shipping"),
          //                         cartController.shipping.value.toString()),
          //                     SizedBox(
          //                       height: 5,
          //                     ),
          //                     cartController.discount.value > 0
          //                         ? linearDashed(
          //                             context,
          //                             App_Localization.of(context)
          //                                 .translate("discount"),
          //                             (cartController.discount.value)
          //                                     .toString() +
          //                                 "%")
          //                         : Center(),
          //                     cartController.discount.value > 0
          //                         ? SizedBox(
          //                             height: 5,
          //                           )
          //                         : Center(),
          //                     cartController.discount.value > 0
          //                         ? linearDashed(
          //                             context,
          //                             App_Localization.of(context)
          //                                 .translate("coupon"),
          //                             cartController.coupon.value.toString())
          //                         : Center(),
          //                     cartController.discount.value > 0
          //                         ? SizedBox(
          //                             height: 5,
          //                           )
          //                         : Center(),
          //                     linearDashed(
          //                         context,
          //                         App_Localization.of(context)
          //                             .translate("total"),
          //                         cartController.total.value.toString()),
          //                     discountTextField(context),
          //                     SizedBox(
          //                       height: 5,
          //                     ),
          //                     SizedBox(
          //                       height: 5,
          //                     ),
          //                     checkOutBtn(context),
          //                   ],
          //                 ),
          //               )
          //             : Center(),
          //       ),
          //       cartController.loading.value
          //           ? Positioned(
          //               child: Container(
          //               width: MediaQuery.of(context).size.width,
          //               height: MediaQuery.of(context).size.height,
          //               color: App.primery.withOpacity(0.5),
          //               child: Center(
          //                 child: CircularProgressIndicator(),
          //               ),
          //             ))
          //           : Center()
          //     ],
          //   ),
          // ),
        ),
      );
    });
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
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.width / 6,
                  color: Colors.white,
                  child: Image.asset('assets/logo.png', fit: BoxFit.fill,),
                ),
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
          const SizedBox(height: 30),
          _checkoutButton(context),

          // _footer1(context),
        ],
      ),
    );
  }

  _cartList(context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text('My cart', style: TextStyle(fontSize: 24, color: App.green,fontWeight: FontWeight.bold),),
          ),
          Divider(color: Colors.black54.withOpacity(0.5),height: 30,),
          cartController.cart.isEmpty
              ? Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: isEmpty(context)
          )
           : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartController.cart.length,
            itemBuilder: (context, index){
              String totalPrice = (double.parse(cartController.cart[index].price) * cartController.cart[index].count ).toString();
              return Obx((){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.width * 0.23,
                            decoration: BoxDecoration(
                                color: App.grey,
                                border: Border.all(color: Colors.black.withOpacity(0.5))
                            ),
                            child: Image.network(cartController.cart[index].post.image.toString()),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartController.cart[index].post.title.toString(),
                                  style: TextStyle(fontSize: 19),
                                ),
                                // Text(homeController.cart[index].price),
                                Text(
                                  cartController.cart[index].price + ' AED',
                                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  totalPrice + ' AED',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: App.grey,
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          cartController.decrease(cartController.cart[index].post,-1, context);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: 45,
                                          height: 40,
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      Container(
                                          width: 75,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              cartController.cart[index].count.toString(),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          )
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          cartController.increase(cartController.cart[index].post,1, context);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: 45,
                                          height: 40,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              cartController.removeFromCart(index);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black,height: 40,)
                    ],
                  ),
                );
              });
            },
          ),
          _inputInfo(context),
          const Divider(color: Colors.black,height: 40,),
          _payInfo(context),
        ],
      ),
    );
  }

  _inputInfo(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            cartController.openPromoCode.value = !cartController.openPromoCode.value;
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.qr_code,color: App.primery,size: 30),
                SizedBox(width: 10),
                Text(
                  'Enter a promo code',
                  style: TextStyle(color: App.primery,fontSize: 20),
                ),
              ],
            ),
          ),
        ),
       AnimatedContainer(
         duration: const Duration(milliseconds: 1000),
         height: cartController.openPromoCode.isTrue ? 15 : 0,
       ),
        AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            width: MediaQuery.of(context).size.width * 0.9,
            height: cartController.openPromoCode.value ? 80 : 0,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 60,
                        child: const Center(
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:BorderSide(
                                    color: Colors.black,
                                    width: 1.0
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0
                                ),
                              ),
                            ),

                          ),
                        )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 60,
                        decoration: BoxDecoration(
                          color: App.grey,
                          border: Border.all(color: App.primery)
                        ),
                        child: Center(
                          child: Text(
                              'Apply',
                            style: TextStyle(color: App.primery,fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        Divider(color: Colors.black,height: 40,),
        GestureDetector(
          onTap: (){
            cartController.openNote.value = !cartController.openNote.value;
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.text_snippet_outlined,color: App.primery,size: 30),
                SizedBox(width: 10),
                Text(
                  'Add a note',
                  style: TextStyle(color: App.primery,fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          height: cartController.openNote.isTrue ? 15 : 0,
        ),
        AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            width: MediaQuery.of(context).size.width * 0.9,
            height: cartController.openNote.value ? 80 : 0,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 60,
                          child: const Center(
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(
                                      color: Colors.black,
                                      width: 1.0
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0
                                  ),
                                ),
                              ),

                            ),
                          )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 60,
                        decoration: BoxDecoration(
                            color: App.grey,
                            border: Border.all(color: App.primery)
                        ),
                        child: Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(color: App.primery,fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }

  _checkoutButton(context){
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        decoration: BoxDecoration(
            color: App.primery,
            borderRadius: BorderRadius.circular(40)
        ),
        child: const Center(
          child: Text(
            'Checkout',
            style: TextStyle(fontSize: 19,color: Colors.white),
          ),
        )
    );
  }

  _payInfo(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SubTotal', style: TextStyle(fontSize: 20),),
              Text(cartController.subTotal.toString() + ' AED', style: TextStyle(fontSize: 20),),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping', style: TextStyle(fontSize: 20),),
              cartController.shipping == 0.0
              ? const Text('FREE', style: TextStyle(fontSize: 20),)
               : Text(cartController.shipping.toString() + ' AED', style: TextStyle(fontSize: 20),),
            ],
          ),
          const SizedBox(height: 10),
          Text('Dubai, Un'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sales Tax', style: TextStyle(fontSize: 20),),
              Text('', style: TextStyle(fontSize: 20),),
            ],
          ),
          const Divider(color: Colors.black,height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontSize: 20),),
              Text(cartController.total.toString() + ' AED', style: TextStyle(fontSize: 20),),
            ],
          ),
          const SizedBox(height: 20),
          _checkoutButton(context),
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
                  margin: EdgeInsets.only(bottom: 10, top: 30),
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

  _drawer(context){
    return Drawer(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/logo.png')
                )
            ),
          ),
          Divider(indent: 50,endIndent: 50,color: Colors.black.withOpacity(0.5),),
          GestureDetector(
            onTap: (){
              Get.offAll(()=>Home());
              homeController.resetValue();
              homeController.listDrawerButtonCheck[0] = true;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'HOME',
                  style: TextStyle(
                      color: homeController.listDrawerButtonCheck[0] == true ? App.primery : Colors.black,
                      fontWeight: homeController.listDrawerButtonCheck[0] == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.off(()=>Cart());
              homeController.resetValue();
              homeController.listDrawerButtonCheck[1] = true;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'CART',
                  style: TextStyle(
                      color: homeController.listDrawerButtonCheck[1] == true ? App.primery : Colors.black,
                      fontWeight: homeController.listDrawerButtonCheck[1] == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              homeController.resetValue();
              homeController.listDrawerButtonCheck[2] = true;
              Get.back();
              Get.off(()=>About());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'ABOUT',
                  style: TextStyle(
                      color: homeController.listDrawerButtonCheck[2] == true ? App.primery : Colors.black,
                      fontWeight: homeController.listDrawerButtonCheck[2] == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              homeController.resetValue();
              homeController.listDrawerButtonCheck[3] = true;
              Get.back();
              Get.off(()=>Gallery());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'GALLERY',
                  style: TextStyle(
                      color: homeController.listDrawerButtonCheck[3] == true ? App.primery : Colors.black,
                      fontWeight: homeController.listDrawerButtonCheck[3] == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              homeController.resetValue();
              homeController.listDrawerButtonCheck[4] = true;
              Get.back();
              Get.off(()=>Contact());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'CONTACT',
                  style: TextStyle(
                      color: homeController.listDrawerButtonCheck[4] == true ? App.primery : Colors.black,
                      fontWeight: homeController.listDrawerButtonCheck[4] == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ),
          ),
        ],
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
