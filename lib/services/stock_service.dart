import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockService {
  Dio api = Api.api();
  String? responseMessage;
  getAllStock() {}

  userStock(Map<String, dynamic> data) async {
    final response = await api.post(
      'stock/view',
      data: data,
    );

    return response.data;
  }

  currentUserStockOrders() async {
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

  getStockOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      'orders',
      options: options,
    );

    return response.data;
  }
}
