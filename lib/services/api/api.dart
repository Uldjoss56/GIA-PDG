/*import 'package:dio/dio.dart';

class Api {
  static api() {
    final options = BaseOptions(
      baseUrl: 'https://test.princedegboe.com/api/v1/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    return Dio(
      options,
    );
  }
}
*/
import 'package:dio/dio.dart';

class Api {
  static Dio api() {
    final options = BaseOptions(
      baseUrl: 'https://test.princedegboe.com/api/v1/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "dev_code": "A3b#6mG8x!2pQzF",
        "Content-Type": "application/json",
      },
    );

    final dio = Dio(options);

    // dio.options.headers["dev_code"] = "A3b#6mG8x!2pQzF";
    // dio.options.headers["Content-Type"] = "application/json";

    return dio;
  }
}
