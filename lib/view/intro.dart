import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/controller/intro_controller.dart';
import 'package:brakly_mobile/model/post.dart';

class Intro extends StatelessWidget {
  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
