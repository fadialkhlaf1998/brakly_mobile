import 'package:get/get.dart';
import 'package:brakly_mobile/controller/cart_contoller.dart';
import 'package:brakly_mobile/controller/home_controller.dart';
import 'package:brakly_mobile/controller/wishlist_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/store.dart';
import 'package:brakly_mobile/model/login_info.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/home.dart';
import 'package:brakly_mobile/view/login.dart';
import 'package:brakly_mobile/view/no_internet.dart';
import 'package:brakly_mobile/view/verification_code.dart';

class IntroController extends GetxController {
  // List<List<Post>> main_posts = [<Post>[]];
  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.put(CartController());
  List<Post> banner = <Post>[];
  List<Post> service = <Post>[];
  List<Post> product = <Post>[];
  List<Post> brands = <Post>[];
  List<Post> category = <Post>[];
  Post? aboutHomePage ;

  WishListController wishListController = Get.put(WishListController());

  @override
  void onInit() {

    super.onInit();
    get_data();
    // get_nave();
  }

  login() async {
    LogInInfo? logInInfo = await Store.loadLogInInfo();
    API.is_active = await Store.isActive();
    if (logInInfo != null) {
      await API.login();
    }
    return;
  }

  get_data() {

    API.checkInternet().then((value) async {
      if (value) {
        // main_posts.clear();
        API.getCompanyId().then((value) async {
          await login();

          banner = await API.getPostByPostType(29);
          brands = await API.getPostByPostType(30);
          service = await API.getPostByPostType(28);
          product = await API.getPostByPostType(27);
          category = await API.getPostByPostType(26);
          aboutHomePage = await API.getPostInfo(83);
          homeController.banner = banner;
          homeController.service = service;
          homeController.product = product;
          homeController.brands = brands;
          homeController.category = category;
          homeController.aboutHomePage = aboutHomePage;
          API.address = await Store.loadAddress();
          cartController.cart.value = await Store.loadCart();
          cartController.saveCart();
          wishListController.wishlist.value = await API.getWishlist();
          get_nave();
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          get_data();
        });
      }
    }).catchError((err) {
      err.printError();
    });
  }

  get_nave() {
    // homeController.main_posts = main_posts;
    homeController.banner = banner;
    homeController.service = service;
    homeController.product = product;
    homeController.brands = brands;
    homeController.category = category;

    Get.to(() => Home());
    if (API.email.isNotEmpty && API.is_active == true) {
      Get.offAll(() => Home());
    } else if (API.email.isNotEmpty && API.is_active == false) {
      Get.to(() => VerificationCode());
    } else {
      Get.offAll(() => LogIn());
    }
  }
}
