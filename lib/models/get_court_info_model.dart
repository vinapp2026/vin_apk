// To parse this JSON data, do
//
//     final getCourtInfoModel = getCourtInfoModelFromJson(jsonString);

import 'dart:convert';

GetCourtInfoModel getCourtInfoModelFromJson(String str) => GetCourtInfoModel.fromJson(json.decode(str));

class GetCourtInfoModel {
  GetCourtInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory GetCourtInfoModel.fromJson(Map<String, dynamic> json) => GetCourtInfoModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.isTechnicalCourt,
    this.courtTypeId,
    this.isBulk,
    this.address,
    this.state,
    this.city,
    this.zip,
    this.status,
    this.extraPricePerHours,
    this.stadiumAddress,
    this.stadiumId,
    this.stadiumAvatar,
    this.courtGallery,
    this.courtTiming,
    this.favouriteData,
  });

  int? id;
  int? userId;
  String? name;
  String? description;
  String? isTechnicalCourt;
  int? courtTypeId;
  String? isBulk;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic zip;
  String? status;
  dynamic extraPricePerHours;
  String? stadiumAddress;
  int? stadiumId;
  String? stadiumAvatar;
  List<CourtGallery>? courtGallery;
  List<CourtTiming>? courtTiming;
  dynamic favouriteData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    isTechnicalCourt: json["isTechnicalCourt"] == null ? null : json["isTechnicalCourt"],
    courtTypeId: json["court_type_id"] == null ? null : json["court_type_id"],
    isBulk: json["is_bulk"] == null ? null : json["is_bulk"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
    status: json["status"] == null ? null : json["status"],
    extraPricePerHours: json["extra_price_per_hours"] == null ? null : json["extra_price_per_hours"],
    stadiumAddress: json["stadiumAddress"] == null ? null : json["stadiumAddress"],
    stadiumId: json["stadiumID"] == null ? null : json["stadiumID"],
    stadiumAvatar: json["stadiumAvatar"] == null ? null : json["stadiumAvatar"],
    courtGallery: json["court_gallery"] == null ? null : List<CourtGallery>.from(json["court_gallery"].map((x) => CourtGallery.fromJson(x))),
    courtTiming: json["court_timing"] == null ? null : List<CourtTiming>.from(json["court_timing"].map((x) => CourtTiming.fromJson(x))),
    favouriteData: json["favourite_data"],
  );

}

class CourtGallery {
  CourtGallery({
    this.id,
    this.courtId,
    this.image,
    this.status,
  });

  int? id;
  int? courtId;
  String? image;
  String? status;

  factory CourtGallery.fromJson(Map<String, dynamic> json) => CourtGallery(
    id: json["id"] == null ? null : json["id"],
    courtId: json["court_id"] == null ? null : json["court_id"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
  );

}

class CourtTiming {
  CourtTiming({
    this.startTiming,
    this.endTiming,
    this.startTime,
    this.endTime,
    this.price,
    this.id,
  });

  String? startTiming;
  String? endTiming;
  String? startTime;
  String? endTime;
  dynamic price;
  int? id;

  factory CourtTiming.fromJson(Map<String, dynamic> json) => CourtTiming(
    startTiming: json["start_timing"] == null ? null : json["start_timing"],
    endTiming: json["end_timing"] == null ? null : json["end_timing"],
    startTime: json["start_time"] == null ? null : json["start_time"],
    endTime: json["end_time"] == null ? null : json["end_time"],
    price: json["price"] == null ? null : json["price"],
    id: json["id"] == null ? null : json["id"],
  );

}
