// To parse this JSON data, do
//
//     final customerOrder = customerOrderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CustomerOrder {
  CustomerOrder({
    required this.id,
    required this.companyId,
    required this.orderNumber,
    required this.createdAt,
    required this.cutomerId,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.phone,
    required this.country,
    required this.state,
    required this.isPaid,
    required this.subTotal,
    required this.shipping,
    required this.total,
    required this.discount,
    required this.orderState,
    required this.current,
  });

  int id;
  int companyId;
  String orderNumber;
  DateTime createdAt;
  int cutomerId;
  String firstName;
  String lastName;
  String address1;
  String address2;
  String phone;
  String country;
  String state;
  int isPaid;
  double subTotal;
  double shipping;
  double total;
  double discount;
  int orderState;
  DateTime current;

  factory CustomerOrder.fromJson(String str) => CustomerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerOrder.fromMap(Map<String, dynamic> json) => CustomerOrder(
    id: json["id"],
    companyId: json["company_id"],
    orderNumber: json["order_number"],
    createdAt: DateTime.parse(json["created_at"]),
    cutomerId: json["cutomer_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    phone: json["phone"],
    country: json["country"],
    state: json["state"],
    isPaid: json["is_paid"]==null?0:json["is_paid"],
    subTotal: double.parse(json["sub_total"]),
    shipping: double.parse(json["shipping"]),
    total: double.parse(json["total"]),
    discount: double.parse(json["discount"]),
    orderState: json["order_state"],
    current: DateTime.parse(json["current"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "company_id": companyId,
    "order_number": orderNumber,
    "created_at": createdAt.toIso8601String(),
    "cutomer_id": cutomerId,
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "phone": phone,
    "country": country,
    "state": state,
    "is_paid": isPaid,
    "sub_total": subTotal,
    "shipping": shipping,
    "total": total,
    "discount": discount,
    "order_state": orderState,
    "current": current.toIso8601String(),
  };
}
