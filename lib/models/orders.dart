import 'dart:convert';

class OrderData {
  final bool? status;
  final List<Order>? orders;

  OrderData({
    this.status,
    this.orders,
  });

  factory OrderData.fromRawJson(String str) =>
      OrderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        status: json["status"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  final int? id;
  final int? authorId;
  final int? receiverId;
  final String? step;
  final int? number;
  final int? isDelivered;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? isCreated;
  final Author? author;

  Order({
    this.id,
    this.authorId,
    this.receiverId,
    this.step,
    this.number,
    this.isDelivered,
    this.createdAt,
    this.updatedAt,
    this.isCreated,
    this.author,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        authorId: json["author_id"],
        receiverId: json["receiver_id"],
        step: json["step"],
        number: json["number"],
        isDelivered: json["is_delivered"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isCreated: json["is_created"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": authorId,
        "receiver_id": receiverId,
        "step": step,
        "number": number,
        "is_delivered": isDelivered,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_created": isCreated,
        "author": author?.toJson(),
      };
}

class Author {
  final int? id;
  final String? name;
  final String? email;
  final dynamic profil;
  final dynamic identityCards;
  final String? sex;
  final dynamic stock;
  final int? countryId;
  final int? isValided;
  final int? roleId;
  final int? validerId;
  final String? codeDistr;
  final String? dateOfBirth;
  final String? confirmCode;
  final dynamic passwordCode;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic fcmToken;
  final int? pv;
  final dynamic b;
  final dynamic ca;

  Author({
    this.id,
    this.name,
    this.email,
    this.profil,
    this.identityCards,
    this.sex,
    this.stock,
    this.countryId,
    this.isValided,
    this.roleId,
    this.validerId,
    this.codeDistr,
    this.dateOfBirth,
    this.confirmCode,
    this.passwordCode,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.pv,
    this.b,
    this.ca,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profil: json["profil"],
        identityCards: json["identity_cards"],
        sex: json["sex"],
        stock: json["stock"],
        countryId: json["country_id"],
        isValided: json["is_valided"],
        roleId: json["role_id"],
        validerId: json["valider_id"],
        codeDistr: json["code_distr"],
        dateOfBirth: json["date_of_birth"],
        confirmCode: json["confirm_code"],
        passwordCode: json["password_code"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
        pv: json["pv"],
        b: json["b"],
        ca: json["ca"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profil": profil,
        "identity_cards": identityCards,
        "sex": sex,
        "stock": stock,
        "country_id": countryId,
        "is_valided": isValided,
        "role_id": roleId,
        "valider_id": validerId,
        "code_distr": codeDistr,
        "date_of_birth": dateOfBirth,
        "confirm_code": confirmCode,
        "password_code": passwordCode,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fcm_token": fcmToken,
        "pv": pv,
        "b": b,
        "ca": ca,
      };
}
