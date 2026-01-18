// To parse this JSON data, do
//
//     final getCourtBulkInfoModel = getCourtBulkInfoModelFromJson(jsonString);

import 'dart:convert';

GetCourtBulkInfoModel getCourtBulkInfoModelFromJson(String str) => GetCourtBulkInfoModel.fromJson(json.decode(str));

class GetCourtBulkInfoModel {
  GetCourtBulkInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory GetCourtBulkInfoModel.fromJson(Map<String, dynamic> json) => GetCourtBulkInfoModel(
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
    this.bulkDuartion,
    this.favouriteData,
  });

  dynamic id;
  dynamic userId;
  String? name;
  String? description;
  String? isTechnicalCourt;
  dynamic courtTypeId;
  String? isBulk;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic zip;
  String? status;
  dynamic extraPricePerHours;
  String? stadiumAddress;
  dynamic stadiumId;
  String? stadiumAvatar;
  List<CourtGallery>? courtGallery;
  List<BulkDuartion>? bulkDuartion;
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
    bulkDuartion: json["bulk_duartion"] == null ? null : List<BulkDuartion>.from(json["bulk_duartion"].map((x) => BulkDuartion.fromJson(x))),
    favouriteData: json["favourite_data"],
  );

}

class BulkDuartion {
  BulkDuartion({
    this.id,
    this.courtId,
    this.noOfDays,
    this.daysLabel,
    this.totalNoOfDays,
    this.status,
    this.timing,
  });

  dynamic id;
  dynamic courtId;
  dynamic noOfDays;
  String? daysLabel;
  dynamic totalNoOfDays;
  String? status;
  List<Timing>? timing;

  factory BulkDuartion.fromJson(Map<String, dynamic> json) => BulkDuartion(
    id: json["id"] == null ? null : json["id"],
    courtId: json["court_id"] == null ? null : json["court_id"],
    noOfDays: json["no_of_days"] == null ? null : json["no_of_days"],
    daysLabel: json["days_label"] == null ? null : json["days_label"],
    totalNoOfDays: json["total_no_of_days"] == null ? null : json["total_no_of_days"],
    status: json["status"] == null ? null : json["status"],
    timing: json["timing"] == null ? null : List<Timing>.from(json["timing"].map((x) => Timing.fromJson(x))),
  );

}

class Timing {
  Timing({
    this.startTiming,
    this.endTiming,
    this.startTime,
    this.endTime,
    this.timingLabel,
    this.price,
    this.id,
  });

  String? startTiming;
  String? endTiming;
  String? startTime;
  String? endTime;
  String? timingLabel;
  dynamic price;
  dynamic id;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    startTiming: json["start_timing"] == null ? null : json["start_timing"],
    endTiming: json["end_timing"] == null ? null : json["end_timing"],
    startTime: json["start_time"] == null ? null : json["start_time"],
    endTime: json["end_time"] == null ? null : json["end_time"],
    timingLabel: json["timing_label"] == null ? null : json["timing_label"],
    price: json["price"] == null ? null : json["price"],
    id: json["id"] == null ? null : json["id"],
  );
}

class CourtGallery {
  CourtGallery({
    this.id,
    this.courtId,
    this.image,
    this.status,
  });

  dynamic id;
  dynamic courtId;
  String? image;
  String? status;

  factory CourtGallery.fromJson(Map<String, dynamic> json) => CourtGallery(
    id: json["id"] == null ? null : json["id"],
    courtId: json["court_id"] == null ? null : json["court_id"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
  );
}
