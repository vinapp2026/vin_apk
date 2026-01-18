// To parse this JSON data, do
//
//     final getCourtListModel = getCourtListModelFromJson(jsonString);

import 'dart:convert';

GetCourtListModel getCourtListModelFromJson(String str) => GetCourtListModel.fromJson(json.decode(str));

class GetCourtListModel {
  GetCourtListModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory GetCourtListModel.fromJson(Map<String, dynamic> json) => GetCourtListModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  Datum({
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
  dynamic stadiumAvatar;
  List<dynamic>? courtGallery;
  List<CourtTiming>? courtTiming;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    stadiumAvatar: json["stadiumAvatar"],
    courtGallery: json["court_gallery"] == null ? null : List<dynamic>.from(json["court_gallery"].map((x) => x)),
    courtTiming: json["court_timing"] == null ? null : List<CourtTiming>.from(json["court_timing"].map((x) => CourtTiming.fromJson(x))),
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
