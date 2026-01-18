// To parse this JSON data, do
//
//     final favouriteListModel = favouriteListModelFromJson(jsonString);

import 'dart:convert';

FavouriteListModel favouriteListModelFromJson(String str) => FavouriteListModel.fromJson(json.decode(str));

class FavouriteListModel {
  FavouriteListModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory FavouriteListModel.fromJson(Map<String, dynamic> json) => FavouriteListModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  Datum({
    this.stadiumId,
    this.stadiumAvatar,
    this.stadiumAddress,
    this.stadiumName,
    this.stadiumLatitude,
    this.stadiumLongtitude,
    this.rating,
    this.gallery,
    this.distance,
    this.disMeasurement,
  });

  int? stadiumId;
  dynamic stadiumAvatar;
  String? stadiumAddress;
  String? stadiumName;
  String? stadiumLatitude;
  String? stadiumLongtitude;
  dynamic rating;
  List<dynamic>? gallery;
  dynamic distance;
  dynamic disMeasurement;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    stadiumId: json["stadiumID"] == null ? null : json["stadiumID"],
    stadiumAvatar: json["stadiumAvatar"],
    stadiumAddress: json["stadiumAddress"] == null ? null : json["stadiumAddress"],
    stadiumName: json["stadiumName"] == null ? null : json["stadiumName"],
    stadiumLatitude: json["stadiumLatitude"] == null ? null : json["stadiumLatitude"],
    stadiumLongtitude: json["stadiumLongtitude"] == null ? null : json["stadiumLongtitude"],
    rating: json["rating"] == null ? null : json["rating"],
    gallery: json["gallery"] == null ? null : List<dynamic>.from(json["gallery"].map((x) => x)),
    distance: json["distance"],
    disMeasurement: json["disMeasurement"],
  );

}
