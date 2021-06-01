import 'package:cowin/models/centres.dart';
import 'package:http/http.dart' as http;

import 'models/district.dart';

class CowinService {
  static Future<List<Centre>> getAllCentresFromDistrict(
      int id, String date) async {
    String url =
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/calendarByDistrict?district_id=$id&date=$date';
    print(url);
    var response = await http.get(Uri.parse(url));
    final centresResponse = centresResponseFromJson(response.body);
    return centresResponse.centers;
  }

  static Future<List<District>> getAllDistricts(int id) async {
    String url =
        'https://cdn-api.co-vin.in/api/v2/admin/location/districts/$id';
    var response = await http.get(Uri.parse(url));
    final districtResponse = districtResponseFromJson(response.body);
    return districtResponse.districts;
  }
}
