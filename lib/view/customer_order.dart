import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/customer_order_controller.dart';
import 'package:brakly_mobile/helper/app.dart';
import 'package:brakly_mobile/model/customer_order.dart';

class CustomerOrderView extends StatelessWidget {
  CustomerOrderController customerOrderController =
      Get.put(CustomerOrderController());

  CustomerOrderView(List<CustomerOrder> orders) {
    customerOrderController.orders = orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(App_Localization.of(context).translate("my_orders")),
          centerTitle: true,
        ),
        body: Obx(() {
          return Stack(
            children: [
              SafeArea(
                child: Container(
                    child: ListView.builder(
                        itemCount: customerOrderController.orders.length,
                        itemBuilder: (context, index) {
                          return item(
                              context, customerOrderController.orders[index]);
                        })),
              ),
              customerOrderController.loading.value
                  ? Positioned(
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: App.primery.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ))
                  : Center()
            ],
          );
        }));
  }

  item(BuildContext context, CustomerOrder orderItem) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context)
                                    .translate("order_number") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            '#' + orderItem.orderNumber,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      state(orderItem.orderState, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context)
                                    .translate("created_at") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            _date_covert(orderItem.createdAt),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("phone") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            orderItem.phone,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("total") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            orderItem.total.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context)
                                    .translate("sub_total") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            orderItem.subTotal.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("discount") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            orderItem.discount.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            App_Localization.of(context).translate("shipping") +
                                ": ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            orderItem.shipping.toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                  orderItem.current.isBefore(orderItem.createdAt) &&
                          orderItem.isPaid != 1 &&
                          orderItem.orderState == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                customerOrderController.viewOrder(
                                    orderItem.id, context);
                              },
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: App.primery,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)
                                        .translate("view_order"),
                                    style: TextStyle(color: App.secondry),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                customerOrderController.cancelOrder(
                                    orderItem.id, context);
                              },
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: App.primery,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)
                                        .translate("cancel_order"),
                                    style: TextStyle(color: App.secondry),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //todo view order
                                customerOrderController.viewOrder(
                                    orderItem.id, context);
                              },
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: App.primery,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)
                                        .translate("view_order"),
                                    style: TextStyle(color: App.secondry),
                                  ),
                                ),
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
    );
  }

  _date_covert(DateTime dateTime) {
    final format = DateFormat('yyyy-MMM-dd hh:mm');
    final clockString = format.format(dateTime);
    return clockString.replaceAll(" ", ",");
  }

  state(int state, BuildContext context) {
    if (state == -1) {
      return Row(
        children: [
          Text(
            App_Localization.of(context).translate("canceled"),
            style: TextStyle(fontSize: 10, color: Colors.red),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.close,
            color: Colors.grey,
            size: 12,
          ),
        ],
      );
    } else if (state == 0) {
      return Row(
        children: [
          Text(
            App_Localization.of(context).translate("pending"),
            style: TextStyle(fontSize: 10, color: Colors.orange),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.history,
            color: Colors.grey,
            size: 12,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            App_Localization.of(context).translate("delivered"),
            style: TextStyle(fontSize: 10, color: Colors.green),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.check_circle,
            color: Colors.grey,
            size: 12,
          ),
        ],
      );
    }
  }
}
