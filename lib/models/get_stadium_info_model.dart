// To parse this JSON data, do
//
//     final getStadiumInfoModel = getStadiumInfoModelFromJson(jsonString);

import 'dart:convert';

GetStadiumInfoModel getStadiumInfoModelFromJson(String str) => GetStadiumInfoModel.fromJson(json.decode(str));

class GetStadiumInfoModel {
  GetStadiumInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory GetStadiumInfoModel.fromJson(Map<String, dynamic> json) => GetStadiumInfoModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.id,
    this.role,
    this.name,
    this.email,
    this.avatar,
    this.status,
    this.noOfCourt,
    this.stadiumAddress,
    this.latitude,
    this.longitude,
    this.stadiumAvatar,
    this.distance,
    this.disMeasurement,
    this.features,
    this.rating,
    this.favouriteData,
    this.isFavourite,
  });

  dynamic id;
  String? role;
  String? name;
  String? email;
  dynamic avatar;
  String? status;
  dynamic noOfCourt;
  String? stadiumAddress;
  String? latitude;
  String? longitude;
  dynamic stadiumAvatar;
  dynamic distance;
  String? disMeasurement;
  List<Feature>? features;
  dynamic rating;
  FavouriteData? favouriteData;
  int? isFavourite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    role: json["role"] == null ? null : json["role"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    avatar: json["avatar"],
    status: json["status"] == null ? null : json["status"],
    noOfCourt: json["no_of_court"] == null ? null : json["no_of_court"],
    stadiumAddress: json["stadiumAddress"] == null ? null : json["stadiumAddress"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    stadiumAvatar: json["stadiumAvatar"],
    distance: json["distance"] == null ? null : json["distance"],
    disMeasurement: json["disMeasurement"] == null ? null : json["disMeasurement"],
    features: json["features"] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    rating: json["rating"] == null ? null : json["rating"],
    favouriteData: json["favourite_data"] == null ? null : FavouriteData.fromJson(json["favourite_data"]),
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
  );
}

class FavouriteData {
  FavouriteData({
    this.id,
    this.isFavourite,
  });

  dynamic id;
  String? isFavourite;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    id: json["id"] == null ? null : json["id"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
  );
}

class Feature {
  Feature({
    this.id,
    this.userId,
    this.featureId,
    this.featureValue,
    this.status,
    this.featureName,
    this.featureAvatar,
  });

  dynamic id;
  dynamic userId;
  dynamic featureId;
  String? featureValue;
  String? status;
  String? featureName;
  String? featureAvatar;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    featureId: json["feature_id"] == null ? null : json["feature_id"],
    featureValue: json["feature_value"] == null ? null : json["feature_value"],
    status: json["status"] == null ? null : json["status"],
    featureName: json["featureName"] == null ? null : json["featureName"],
    featureAvatar: json["featureAvatar"] == null ? null : json["featureAvatar"],
  );
}
