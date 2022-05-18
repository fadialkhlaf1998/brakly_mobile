import 'dart:convert';
import 'package:brakly_mobile/model/post.dart';

class LineItemDecoder {
  List<LineItem> cart;

  LineItemDecoder({required this.cart});

  factory LineItemDecoder.fromJson(String str) =>
      LineItemDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItemDecoder.fromMap(Map<String, dynamic> json) => LineItemDecoder(
        cart: List<LineItem>.from(json["cart"].map((x) => LineItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toMap())),
      };
}

class LineItem {
  Post post;
  int count;
  String price;
  int post_id;

  LineItem(
      {required this.post,
      required this.count,
      required this.price,
      required this.post_id});

  factory LineItem.fromJson(String str) => LineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItem.fromMap(Map<String, dynamic> json) => LineItem(
        post: Post.fromMap(json["post"]),
        count: json["count"],
        price: json["price"],
        post_id: json["post_id"],
      );

  Map<String, dynamic> toMap() => {
        "post": post.toMap(),
        "count": count,
        "price": price,
        "post_id": post.id
      };
}
