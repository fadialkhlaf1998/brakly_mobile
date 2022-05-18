import 'dart:convert';

class Address {
  String email;
  String address1;
  String address2;
  String apartment;
  String phone;
  String phone_pref;
  String ISO_code;
  String country;
  String state;

  Address({required this.email, required this.address1, required this.address2, required this.apartment, required this.phone,
    required this.country,required this.state,required this.phone_pref,required this.ISO_code});

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    email: json["email"],
    address1: json["address1"],
    address2: json["address2"],
    apartment: json["apartment"],
    phone: json["phone"],
    country: json["country"],
    state: json["state"],
    phone_pref: json["phone_pref"],
    ISO_code: json["ISO_code"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "address1": address1,
    "address2": address2,
    "apartment": apartment,
    "phone": phone,
    "country": country,
    "state": state,
    "phone_pref": phone_pref,
    "ISO_code": ISO_code,
  };
}