import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';

class OtherService {
  Dio api = Api.api();
  String? responseMessage;

  Future<RolesData> getAllRoles() async {
    final response = await api.get(
      "roles",
    );
    return RolesData.fromJson(response.data);
  }

  Future<DevicesData> getAllDevices() async {
    final response = await api.get(
      "devices",
    );
    return DevicesData.fromJson(response.data);
  }

  Future<CountriesData> getAllCountries() async {
    final response = await api.get(
      "countries",
    );
    return CountriesData.fromJson(response.data);
  }
}
