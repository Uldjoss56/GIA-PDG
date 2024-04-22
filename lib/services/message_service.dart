import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/user_message.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  Dio api = Api.api();
  String? responseMessage;

  Future sendMessage(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.post(
      'message/send',
      data: data,
      options: options,
    );
    return response.data;
  }

  Future<UserMessages> getAllMessages(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'message/all',
      data: data,
      options: options,
    );
    return UserMessages.fromJson(response.data);
  }
}
