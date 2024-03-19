import 'package:http/http.dart' as http;

Future<bool> checkUserConnexion() async {
  try {
    final url = Uri.parse(
      '''https://www.google.com''',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
