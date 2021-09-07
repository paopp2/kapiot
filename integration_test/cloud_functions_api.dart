import 'package:http/http.dart' as http;

class CloudFunctionsApi {
  static Future<void> populateAll() async {
    final url =
        Uri.parse('http://10.0.2.2:5001/kapiot-46cbc/us-central1/populateAll');
    await http.get(url);
  }

  static Future<void> acceptRider({
    required int riderIdx,
    required int driverIdx,
  }) async {
    final url = Uri.parse(
        "http://10.0.2.2:5001/kapiot-46cbc/us-central1/acceptRider?r=$riderIdx&d=$driverIdx");
    await http.get(url);
  }

  static Future<void> dropRider({
    required int riderIdx,
    required int driverIdx,
  }) async {
    final url = Uri.parse(
        "http://10.0.2.2:5001/kapiot-46cbc/us-central1/dropRider?r=$riderIdx&d=$driverIdx");
    await http.get(url);
  }
}
