import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DmaService {
  Dio api = Api.api();
  String? responseMessage;
  getAllDma() {}

  orderDma(Map<String, dynamic> data) async {
    final response = await api.post(
      'orders/init',
      data: data,
    );

    return response.data;
  }

  currentUserDmaOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'orders/me',
      options: options,
    );

    return response.data;
  }

  Future<OrderData> getDMAOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'orders',
      options: options,
    );

    return OrderData.fromJson(response.data);
  }
}
