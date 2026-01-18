// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

class NotificationModel {
  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  Datum({
    this.createdTime,
    this.createdDate,
    this.createdAt,
    this.id,
    this.playerId,
    this.bookingId,
    this.orderId,
    this.comment,
    this.status,
  });

  String? createdTime;
  DateTime? createdDate;
  String? createdAt;
  int? id;
  int? playerId;
  int? bookingId;
  int? orderId;
  String? comment;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    createdTime: json["created_time"] == null ? null : json["created_time"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    id: json["id"] == null ? null : json["id"],
    playerId: json["player_id"] == null ? null : json["player_id"],
    bookingId: json["booking_id"] == null ? null : json["booking_id"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    comment: json["comment"] == null ? null : json["comment"],
    status: json["status"] == null ? null : json["status"],
  );
}
