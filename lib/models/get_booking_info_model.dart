// To parse this JSON data, do
//
//     final getBookingInfoModel = getBookingInfoModelFromJson(jsonString);

import 'dart:convert';

GetBookingInfoModel getBookingInfoModelFromJson(String str) => GetBookingInfoModel.fromJson(json.decode(str));

class GetBookingInfoModel {
  GetBookingInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory GetBookingInfoModel.fromJson(Map<String, dynamic> json) => GetBookingInfoModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
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
    this.userName,
    this.userAvatar,
    this.courtName,
    this.isTechnicalCourt,
    this.stadiumName,
    this.stadiumAvatar,
    this.stadiumAddress,
    this.timing,
  });

  int? id;
  int? playerId;
  int? courtId;
  dynamic slotId;
  dynamic timeId;
  String? bookingType;
  dynamic amount;
  dynamic noOfPlayers;
  String? bookingDateTime;
  String? bookingStatus;
  String? status;
  String? userName;
  String? userAvatar;
  String? courtName;
  String? isTechnicalCourt;
  String? stadiumName;
  dynamic stadiumAvatar;
  String? stadiumAddress;
  Timing? timing;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    userName: json["userName"] == null ? null : json["userName"],
    userAvatar: json["userAvatar"] == null ? null : json["userAvatar"],
    courtName: json["courtName"] == null ? null : json["courtName"],
    isTechnicalCourt: json["isTechnicalCourt"] == null ? null : json["isTechnicalCourt"],
    stadiumName: json["stadiumName"] == null ? null : json["stadiumName"],
    stadiumAvatar: json["stadiumAvatar"],
    stadiumAddress: json["stadiumAddress"] == null ? null : json["stadiumAddress"],
    timing: json["timing"] == null ? null : Timing.fromJson(json["timing"]),
  );
}

class Timing {
  Timing({
    this.startTime,
    this.endTiming,
    this.price,
    this.id,
  });

  String? startTime;
  String? endTiming;
  dynamic price;
  int? id;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    startTime: json["start_time"] == null ? null : json["start_time"],
    endTiming: json["end_timing"] == null ? null : json["end_timing"],
    price: json["price"] == null ? null : json["price"],
    id: json["id"] == null ? null : json["id"],
  );

}
