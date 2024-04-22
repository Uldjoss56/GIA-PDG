import 'dart:convert';

class UserMessages {
  final List<Message>? messages;

  UserMessages({
    this.messages,
  });

  factory UserMessages.fromRawJson(String str) =>
      UserMessages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserMessages.fromJson(Map<String, dynamic> json) => UserMessages(
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  final int? messageId;
  final int? idSender;
  final String? text;
  final int? idReceiver;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    this.messageId,
    this.idSender,
    this.text,
    this.idReceiver,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageId: json["message_id"],
        idSender: json["id_sender"],
        text: json["text"],
        idReceiver: json["id_receiver"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "id_sender": idSender,
        "text": text,
        "id_receiver": idReceiver,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
