import 'package:http/http.dart' as http;

class CloudFunctionsApi {
  static Future<void> populateAll() async {
    final url =
        Uri.parse('http://10.0.2.2:5001/kapiot-46cbc/us-central1/populateAll');
    await http.get(url);
  }

  static Future<void> acceptRider(int r) async {
    final url = Uri.parse(
        "http://10.0.2.2:5001/kapiot-46cbc/us-central1/acceptRider?r=$r&d=4");
    await http.get(url);
  }
}
