import 'package:get/get.dart';
import 'package:brakly_mobile/model/post.dart';

class PostListController extends GetxController {
  Rx<bool> loading = false.obs;
  Rx<bool> fake = false.obs;
  RxList<Post> posts = <Post>[].obs;
}
