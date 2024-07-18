// To parse this JSON data, do
//
//     final modelListMahasiswa = modelListMahasiswaFromJson(jsonString);

import 'dart:convert';

ModelListMahasiswa modelListMahasiswaFromJson(String str) => ModelListMahasiswa.fromJson(json.decode(str));

String modelListMahasiswaToJson(ModelListMahasiswa data) => json.encode(data.toJson());

class ModelListMahasiswa {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelListMahasiswa({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelListMahasiswa.fromJson(Map<String, dynamic> json) => ModelListMahasiswa(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String namaMahasiswa;
  String noBp;
  String email;
  String jenisKelamin;

  Datum({
    required this.id,
    required this.namaMahasiswa,
    required this.noBp,
    required this.email,
    required this.jenisKelamin,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaMahasiswa: json["nama_mahasiswa"],
    noBp: json["no_bp"],
    email: json["email"],
    jenisKelamin: json["jenis_kelamin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_mahasiswa": namaMahasiswa,
    "no_bp": noBp,
    "email": email,
    "jenis_kelamin": jenisKelamin,
  };
}
