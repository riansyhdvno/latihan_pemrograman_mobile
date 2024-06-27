// To parse this JSON data, do
//
//     final modelVideo = modelVideoFromJson(jsonString);

import 'dart:convert';

ModelVideo modelVideoFromJson(String str) => ModelVideo.fromJson(json.decode(str));

String modelVideoToJson(ModelVideo data) => json.encode(data.toJson());

class ModelVideo {
  bool isSuccess;
  String message;
  List<DatumVideo> data;

  ModelVideo({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelVideo.fromJson(Map<String, dynamic> json) => ModelVideo(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<DatumVideo>.from(json["data"].map((x) => DatumVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumVideo {
  String id;
  String judul;
  String video;
  String thumbnail;

  DatumVideo({
    required this.id,
    required this.judul,
    required this.video,
    required this.thumbnail,
  });

  factory DatumVideo.fromJson(Map<String, dynamic> json) => DatumVideo(
    id: json["id"],
    judul: json["judul"],
    video: json["video"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "video": video,
    "thumbnail": thumbnail,
  };
}