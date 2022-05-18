import 'package:flutter/material.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/post.dart';

class OrderItems extends StatelessWidget {
  List<Post> posts;

  OrderItems(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("my_orders")),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return item(context, posts[index]);
          }),
    );
  }

  item(BuildContext context, Post post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 120,
            decoration: BoxDecoration(
                color: App.secondry,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(2, 2),
                      spreadRadius: 1,
                      blurRadius: 10)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: App.secondry,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(post.image!
                                .replaceAll("localhost", "10.0.2.2")))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title!,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              App_Localization.of(context)
                                      .translate("quantity") +
                                  ": ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            post.count!.toString(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              App_Localization.of(context)
                                      .translate("price_per_pice") +
                                  ": ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            post.price!.toString() +
                                " " +
                                App_Localization.of(context).translate("aed"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              App_Localization.of(context).translate("total") +
                                  ": ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            post.price!.toString() +
                                " " +
                                App_Localization.of(context).translate("aed"),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
