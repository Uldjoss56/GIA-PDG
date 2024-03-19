import 'dart:convert';

import 'package:http/http.dart' as http;

class MapsService {
  Future<String> getPosition({required final lat, required final long}) async {
        final url = Uri.parse(
          '''https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyBO54uguC9CWHZxlcC6pSbuoYll3EPtdSM''',
    );
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    return address;
  }

  String getLocationImage({required double long, required double lat}) {
    return """https://maps.googleapis.com/maps/api/staticmap?center=
    $lat,$long
    &zoom=16&size=600x300&maptype=roadmap
    &markers=color:red%7Clabel:A%7C$lat,$long
    &key=AIzaSyBO54uguC9CWHZxlcC6pSbuoYll3EPtdSM""";
  }
}
