// To parse this JSON data, do
//
//     final saveBookingInfoModel = saveBookingInfoModelFromJson(jsonString);

import 'dart:convert';

SaveBookingInfoModel saveBookingInfoModelFromJson(String str) => SaveBookingInfoModel.fromJson(json.decode(str));

class SaveBookingInfoModel {
  SaveBookingInfoModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory SaveBookingInfoModel.fromJson(Map<String, dynamic> json) => SaveBookingInfoModel(
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
    this.orderId,
  });

  dynamic id;
  dynamic playerId;
  dynamic courtId;
  dynamic slotId;
  dynamic timeId;
  dynamic bookingType;
  dynamic amount;
  dynamic noOfPlayers;
  dynamic bookingDateTime;
  dynamic bookingStatus;
  dynamic status;
  dynamic orderId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    playerId: json["player_id"] == null ? null : json["player_id"],
    courtId: json["court_id"] == null ? null : json["court_id"],
    slotId: json["slot_id"] == null ? null : json["slot_id"],
    timeId: json["time_id"] == null ? null : json["time_id"],
    bookingType: json["booking_type"] == null ? null : json["booking_type"],
    amount: json["amount"] == null ? null : json["amount"],
    noOfPlayers: json["no_of_players"],
    bookingDateTime: json["booking_date_time"] == null ? null : json["booking_date_time"],
    bookingStatus: json["booking_status"] == null ? null : json["booking_status"],
    status: json["status"] == null ? null : json["status"],
    orderId: json["orderID"] == null ? null : json["orderID"],
  );
}
