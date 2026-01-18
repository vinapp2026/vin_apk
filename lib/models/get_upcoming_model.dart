// To parse this JSON data, do
//
//     final getUpcomingInfoModel = getUpcomingInfoModelFromJson(jsonString);

import 'dart:convert';

GetUpcomingInfoModel getUpcomingInfoModelFromJson(String str) => GetUpcomingInfoModel.fromJson(json.decode(str));

class GetUpcomingInfoModel {
  GetUpcomingInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory GetUpcomingInfoModel.fromJson(Map<String, dynamic> json) => GetUpcomingInfoModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  Datum({
    this.id,
    this.playerId,
    this.courtId,
    this.slotId,
    this.timeId,
    this.bookingType,
    this.amount,
    this.noOfPlayers,
    this.bookingDateTime,
    this.bookingStatus,
    this.status,
    this.courtName,
    this.isTechnicalCourt,
    this.description,
    this.stadiumAddress,
    this.stadiumId,
    this.stadiumAvatar,
  });

  int? id;
  int? playerId;
  int? courtId;
  int? slotId;
  dynamic timeId;
  String? bookingType;
  dynamic amount;
  dynamic noOfPlayers;
  String? bookingDateTime;
  String? bookingStatus;
  String? status;
  String? courtName;
  String? isTechnicalCourt;
  String? description;
  String? stadiumAddress;
  int? stadiumId;
  dynamic stadiumAvatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    playerId: json["player_id"] == null ? null : json["player_id"],
    courtId: json["court_id"] == null ? null : json["court_id"],
    slotId: json["slot_id"] == null ? null : json["slot_id"],
    timeId: json["time_id"],
    bookingType: json["booking_type"] == null ? null : json["booking_type"],
    amount: json["amount"] == null ? null : json["amount"],
    noOfPlayers: json["no_of_players"],
    bookingDateTime: json["booking_date_time"] == null ? null : json["booking_date_time"],
    bookingStatus: json["booking_status"] == null ? null : json["booking_status"],
    status: json["status"] == null ? null : json["status"],
    courtName: json["courtName"] == null ? null : json["courtName"],
    isTechnicalCourt: json["isTechnicalCourt"] == null ? null : json["isTechnicalCourt"],
    description: json["description"] == null ? null : json["description"],
    stadiumAddress: json["stadiumAddress"] == null ? null : json["stadiumAddress"],
    stadiumId: json["stadiumID"] == null ? null : json["stadiumID"],
    stadiumAvatar: json["stadiumAvatar"],
  );
}
