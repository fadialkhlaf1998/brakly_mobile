import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/view/home.dart';

class ImageShow extends StatelessWidget {
  String image;

  ImageShow(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: Center(
        child: SafeArea(
            child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            color: App.primery,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // _header(context),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.1),
                  child: PhotoView(
                    imageProvider:
                        NetworkImage(image.replaceAll("localhost", "10.0.2.2")),
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
