import 'dart:convert';

class UserConnecting {
  final bool? status;
  final User? user;
  final Authorization? authorization;

  UserConnecting({
    this.status,
    this.user,
    this.authorization,
  });

  factory UserConnecting.fromRawJson(String str) =>
      UserConnecting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserConnecting.fromJson(Map<String, dynamic> json) => UserConnecting(
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        authorization: json["authorization"] == null
            ? null
            : Authorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
        "authorization": authorization?.toJson(),
      };
}

class Authorization {
  final String? token;
  final String? type;

  Authorization({
    this.token,
    this.type,
  });

  factory Authorization.fromRawJson(String str) =>
      Authorization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        token: json["token"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
      };
}

class UserUpdateData {
  final bool? status;
  final String? message;
  final User? user;

  UserUpdateData({
    this.status,
    this.message,
    this.user,
  });

  factory UserUpdateData.fromRawJson(String str) =>
      UserUpdateData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserUpdateData.fromJson(Map<String, dynamic> json) => UserUpdateData(
        status: json["status"],
        message: json["message"],
        user: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? profil;
  final dynamic identityCards;
  final String? sex;
  final String? stock;
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
  final int? b;
  final int? ca;
  final dynamic benef;
  final dynamic puBenef;

  User({
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
    this.benef,
    this.puBenef,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profil: json["profil"],
        identityCards: json["identity_cards"],
        sex: json["sex"],
        stock: json["stock"],
        countryId: json["country_id"] == null
            ? null
            : double.parse(json["country_id"].toString()).toInt(),
        isValided: json["is_valided"],
        roleId: json["role_id"] == null
            ? null
            : double.parse(json["role_id"].toString()).toInt(),
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
        pv: json["pv"] == null
            ? null
            : double.parse(json["pv"].toString()).toInt(),
        b: json["b"] == null
            ? null
            : double.parse(json["b"].toString()).toInt(),
        ca: json["ca"] == null
            ? null
            : double.parse(json["ca"].toString()).toInt(),
        benef: json["benef"],
        puBenef: json["pu_benef"],
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
        "benef": benef,
        "pu_benef": puBenef,
      };
}
