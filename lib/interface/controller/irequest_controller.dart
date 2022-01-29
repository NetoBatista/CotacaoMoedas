import 'package:http/http.dart';

abstract class IRequestController {
  Future<Response> post(String url, dynamic object);
  Future<Response> get(String url, dynamic object);
  Future<Response> delete(String url, dynamic object);
  Future<Response> put(String url, dynamic object);
}