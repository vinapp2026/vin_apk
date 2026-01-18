// To parse this JSON data, do
//
//     final getStatiumListModel = getStatiumListModelFromJson(jsonString);

import 'dart:convert';

GetStadiumListModel getStatiumListModelFromJson(String str) => GetStadiumListModel.fromJson(json.decode(str));

String getStatiumListModelToJson(GetStadiumListModel data) => json.encode(data.toJson());

class GetStadiumListModel {
  GetStadiumListModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory GetStadiumListModel.fromJson(Map<String, dynamic> json) => GetStadiumListModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.role,
    this.name,
    this.email,
    this.avatar,
    this.status,
    this.noOfCourt,
    this.address,
    this.latitude,
    this.longitude,
    this.stadiumAvatar,
    this.rating,
    this.distance,
    this.disMeasurement,
    this.isTechnicalCourt,
    this.favouriteData,
    this.isFavourite,
  });

  int? id;
  String? role;
  String? name;
  String? email;
  dynamic avatar;
  String? status;
  dynamic noOfCourt;
  String? address;
  dynamic latitude;
  dynamic longitude;
  dynamic stadiumAvatar;
  dynamic rating;
  dynamic distance;
  String? disMeasurement;
  dynamic isTechnicalCourt;
  dynamic favouriteData;
  dynamic isFavourite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    role: json["role"] == null ? null : json["role"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    avatar: json["avatar"],
    status: json["status"] == null ? null : json["status"],
    noOfCourt: json["no_of_court"] == null ? null : json["no_of_court"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    stadiumAvatar: json["stadiumAvatar"],
    rating: json["rating"] == null ? null : json["rating"],
    distance: json["distance"] == null ? null : json["distance"],
    disMeasurement: json["disMeasurement"] == null ? null : json["disMeasurement"],
    isTechnicalCourt: json["isTechnicalCourt"] == null ? null : json["isTechnicalCourt"],
    favouriteData: json["favourite_data"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "role": role == null ? null : role,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "avatar": avatar,
    "status": status == null ? null : status,
    "no_of_court": noOfCourt == null ? null : noOfCourt,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "stadiumAvatar": stadiumAvatar,
    "rating": rating == null ? null : rating,
    "distance": distance == null ? null : distance,
    "disMeasurement": disMeasurement == null ? null : disMeasurement,
    "isTechnicalCourt": isTechnicalCourt == null ? null : isTechnicalCourt,
    "favourite_data": favouriteData,
    "is_favourite": isFavourite == null ? null : isFavourite,
  };
}
