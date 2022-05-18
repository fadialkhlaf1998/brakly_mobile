import 'dart:convert';

class LogInInfo {
  LogInInfo({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LogInInfo.fromJson(String str) => LogInInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogInInfo.fromMap(Map<String, dynamic> json) => LogInInfo(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };
}
