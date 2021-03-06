import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/cart.dart';
import 'package:brakly_mobile/view/contact.dart';
import 'package:brakly_mobile/view/gallery.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class About extends StatelessWidget {

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        persistentFooterButtons: [
          GestureDetector(
            onTap: (){

            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.chat,size: 30),
                      Text('Chat'),
                    ],
                  )
              ),
            ),
          ),
        ],
        endDrawer: _drawer(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  _header(context),
                  const SizedBox(height: 25),
                  _body(context),
                  _footer(context),
                  _footer1(context),
                ],
              ),
            ),
          ),
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
                  homeController.resetValue();
                  homeController.listDrawerButtonCheck[0] = true;
                  Get.offAll(()=>Home());
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
        ],
      ),
    );
  }
  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: App.grey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text('OUR STORY',style: TextStyle(color: App.green,fontWeight: FontWeight.bold, fontSize: 30),),
            SizedBox(height: 20),
            Text(
                homeController.aboutMainPage!.subTitle.toString(),
              style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: App.primery),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:  homeController.aboutMainPage!.jsonData!.length,
                itemBuilder: (context, index){
                  return Container(
                    child:  Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                              homeController.aboutMainPage!.jsonData![index].data.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        index == 1 ? Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 150,
                          child: Image.network(homeController.aboutMainPage!.image.toString(),fit: BoxFit.cover),
                        ) : SizedBox(height: 0,)
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        ),
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

  _footer1(context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Center(
        child: Text('??2022 by The Barkley Pet Camp',style: TextStyle(fontSize: 13),),
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



}
