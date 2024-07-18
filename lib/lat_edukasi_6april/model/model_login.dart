
// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  int value;
  String? message;
  String? username;
  String? nama;
  String? email;
  String? nohp;
  String? password;
  String? id;

  ModelLogin({
    required this.value,
    this.message,
    this.username,
    this.nama,
    this.email,
    this.nohp,
    this.password,
    this.id,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    value: json["value"],
    message: json["message"],
    username: json["username"],
    nama: json["nama"],
    email: json["email"],
    nohp: json["nohp"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "nama": nama,
    "email": email,
    "nohp": nohp,
    "password": password,
    "id": id,
  };
}
