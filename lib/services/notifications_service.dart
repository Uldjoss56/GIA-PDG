import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/notifications.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  Dio api = Api.api();
  String? responseMessage;

  Future<NotificationsData> getUnreadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'notif/unread',
      options: options,
    );

    return NotificationsData.fromJson(response.data);
  }

  Future<NotificationsData> getReadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'notif/read',
      options: options,
    );

    return NotificationsData.fromJson(response.data);
  }

  Future<NotificationsData> unreadNotificationsNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'notif/unread/number',
      options: options,
    );

    return NotificationsData.fromJson(response.data);
  }

  markNotificationsAsRead(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.put(
      'notif/$id/read',
      options: options,
    );

    return response.data;
  }
}
