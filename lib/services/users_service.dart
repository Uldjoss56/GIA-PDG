import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Dio api = Api.api();
  String? responseMessage;

  Future createUser(Map<String, dynamic> data) async {
    final response = await api.post(
      'register',
      data: data,
    );

    return response.data;
  }

  Future<UserConnecting> connectUser(Map<String, dynamic> data) async {
    final response = await api.post(
      'login',
      data: data,
    );
    return UserConnecting.fromJson(response.data);
  }

  Future<User> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      "user",
      options: options,
    );
    return User.fromJson(response.data);
  }

  Future getUsersByRole(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.post(
      "user/getUsersByRole",
      options: options,
      data: data,
    );
    return response.data;
  }

  Future getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      "users",
      options: options,
    );
    return response.data;
  }

  Future disconnectUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.post(
      "logout",
      options: options,
    );
    return response.data;
  }

  Future mailVerify(Map<String, dynamic> data) async {
    final response = await api.post(
      'emailverify',
      data: data,
    );

    return response.data;
  }

  Future resentMail(Map<String, dynamic> data) async {
    final response = await api.post(
      'emailverifyresend',
      data: data,
    );

    return response.data;
  }

  Future validRegistration(int id, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });

    final response = await api.put(
      'validInscrption/$id',
      options: options,
      data: data,
    );
    return response.data;
  }

  Future updateUser(int id, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });

    final response = await api.put(
      'user/update/$id',
      options: options,
      data: data,
    );

    return response.data;
  }
}
