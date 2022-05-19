import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:brakly_mobile/controller/posts_list_controller.dart';
import 'package:brakly_mobile/controller/product_info_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/model/post.dart';
import 'package:brakly_mobile/view/no_internet.dart';
import 'package:brakly_mobile/view/posts_list.dart';
import 'package:brakly_mobile/view/product_info.dart';

class HomeController extends GetxController {
  PostListController postListController = Get.put(PostListController());
  ProductInfoController productInfoController =
      Get.put(ProductInfoController());
  List<List<Post>> main_posts = [<Post>[]];
  Rx<bool> loading = false.obs;
  Rx<int> btmNavBarIndex = 0.obs;
  RxList<Post> products = <Post>[].obs;
  Rx<Post>? productInfo;

  List<Post> banner = <Post>[];
  List<Post> service = <Post>[];
  List<Post> product = <Post>[];
  List<Post> brands = <Post>[];
  List<Post> category = <Post>[];
  List<Post> gallery = <Post>[];
  Post? aboutHomePage ;
  Post? aboutMainPage ;
  RxList<bool> listDrawerButtonCheck =  List.filled(4, false).obs;

  @override
  void onInit(){
    super.onInit();
    // RxList<bool> listDrawerButtonCheck = List.filled(4, false).obs;
    listDrawerButtonCheck[0] = true;

  }

  resetValue(){
    for(int i = 0; i <  listDrawerButtonCheck.length; i++){
      listDrawerButtonCheck[i] = false;
    }
  }



  doFunction(int op, int id, BuildContext context) {
    switch (op) {
      case 0:
        getPostInfo(id);
        break;
      case 1:
        getByParent1(id, context);
        break;
      case 2:
        getByParent2(id, context);
        break;
      case 3:
        getByParent3(id, context);
        break;
      case 4:
        getByParent4(id, context);
        break;
      case 5:
        getByParent5(id, context);
        break;
      case 6:
        getPostByPostType(id, context);
        break;
    }
  }

  getPostInfo(int postId) {
    productInfoController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        Get.to(() => ProductInfo());
        API.getPostInfo(postId).then((product_result) {
          productInfo = product_result!.obs;
          productInfoController.post = product_result;
          productInfoController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getPostInfo(postId);
        });
      }
    });
  }

  getByParent1(int parentId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getByParent1(parentId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getByParent1(parentId, context);
        });
      }
    });
  }

  getByParent2(int parentId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getByParent2(parentId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getByParent2(parentId, context);
        });
      }
    });
  }

  getByParent3(int parentId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getByParent3(parentId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getByParent3(parentId, context);
        });
      }
    });
  }

  getByParent4(int parentId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getByParent4(parentId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getByParent4(parentId, context);
        });
      }
    });
  }

  getByParent5(int parentId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getByParent5(parentId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getByParent5(parentId, context);
        });
      }
    });
  }

  getPostByPostType(int postTypeId, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.getPostByPostType(postTypeId).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          getPostByPostType(postTypeId, context);
        });
      }
    });
  }

  search(String query, BuildContext context) {
    Get.to(() => PostList());
    postListController.loading.value = true;
    API.checkInternet().then((internet) {
      if (internet) {
        API.search(query).then((products_result) {
          postListController.posts.value = products_result;
          postListController.loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          search(query, context);
        });
      }
    });
  }

  //   search(String query,BuildContext context){
  //   loading.value=true;
  //   API.checkInternet().then((internet) {
  //     if(internet){
  //       API.search(query).then((products_result) {
  //         if(products_result.isNotEmpty){
  //           if(products_result.first.postTypeId==API.product){
  //             Get.to(()=>ProductList(products_result));
  //           }else{
  //             Get.to(()=>FilterList(products_result));
  //           }
  //         }else{
  //           App.error_msg(context, App_Localization.of(context).translate("no_elements"));
  //         }
  //         products = products_result.obs;
  //         loading.value=false;
  //       });
  //     }else{
  //       Get.to(()=>NoInternet())!.then((value){
  //         search(query,context);
  //       });
  //     }
  //   });
  // }
}
