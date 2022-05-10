import 'package:http/http.dart' as http;
import 'package:sup/utils/constant_value.dart';


class Request {
  final String url;
  final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> post() {
    return http.post(Uri.parse(HTTPS_BASE_URL+url), body: body).timeout(Duration(minutes: 2));
  }

  Future<http.Response> get() {
    return http.get(Uri.parse(HTTPS_BASE_URL+url)).timeout(Duration(minutes: 2));
  }

  Future<http.Response> delete() {
    return http.delete(Uri.parse(HTTPS_BASE_URL+url)).timeout(Duration(minutes: 2));
  }
}
