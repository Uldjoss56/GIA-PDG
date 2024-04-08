import 'package:dio/dio.dart';
import 'package:gia_pdg_partenaire/models/product.dart';
import 'package:gia_pdg_partenaire/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  Dio api = Api.api();
  String? responseMessage;

  Future<ProductAuthData> authProduct(String productID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });

    final response = await api.get(
      'product/auth/$productID',
      options: options,
    );

    return ProductAuthData.fromJson(response.data);
  }

  Future<ProductData> getUserProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      "user/viewMyProd",
      options: options,
    );
    return ProductData.fromJson(response.data);
  }

  Future getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.get(
      "products",
      options: options,
    );
    return response.data;
  }

  Future setProductToC(String productID, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('userToken') ?? "";

    final options = Options(headers: {
      "Authorization": "Bearer $userToken",
    });
    final response = await api.put(
      'product/affectToC/$productID',
      options: options,
      data: data,
    );
    return response.data;
  }
}
