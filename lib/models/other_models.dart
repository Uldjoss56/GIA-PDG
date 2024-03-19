import 'dart:convert';

class CountriesData {
  final bool? status;
  final List<Country>? countries;

  CountriesData({
    this.status,
    this.countries,
  });

  factory CountriesData.fromRawJson(String str) =>
      CountriesData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountriesData.fromJson(Map<String, dynamic> json) => CountriesData(
        status: json["status"],
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  final int? countryId;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Country({
    this.countryId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class DevicesData {
  final bool? status;
  final List<Device>? devices;

  DevicesData({
    this.status,
    this.devices,
  });

  factory DevicesData.fromRawJson(String str) =>
      DevicesData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DevicesData.fromJson(Map<String, dynamic> json) => DevicesData(
        status: json["status"],
        devices: json["devices"] == null
            ? []
            : List<Device>.from(
                json["devices"]!.map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "devices": devices == null
            ? []
            : List<dynamic>.from(devices!.map((x) => x.toJson())),
      };
}

class Device {
  final int? deviceId;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Device({
    this.deviceId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        deviceId: json["device_id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class RolesData {
  final bool? status;
  final List<Role>? roles;

  RolesData({
    this.status,
    this.roles,
  });

  factory RolesData.fromRawJson(String str) =>
      RolesData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RolesData.fromJson(Map<String, dynamic> json) => RolesData(
        status: json["status"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  final int? roleId;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Role({
    this.roleId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["role_id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
