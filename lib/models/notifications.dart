import 'dart:convert';

class NotificationsData {
  final List<UserNotification>? notifications;

  NotificationsData({
    this.notifications,
  });

  factory NotificationsData.fromRawJson(String str) =>
      NotificationsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      NotificationsData(
        notifications: json["notifications"] == null
            ? []
            : List<UserNotification>.from(json["notifications"]!
                .map((x) => UserNotification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class UserNotification {
  final String? id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final Data? data;
  final DateTime? readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserNotification({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserNotification.fromRawJson(String str) =>
      UserNotification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        readAt:
            json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data?.toJson(),
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Data {
  final int? orderId;
  final int? userId;

  Data({
    this.orderId,
    this.userId,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
      };
}
