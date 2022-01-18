import 'dart:convert';

import 'package:cotacao_moeda/interface/controller/irequest_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class RequestController implements IRequestController {

  @override
  Future<Response> delete(String url, dynamic object) async {
    return _request('delete', url, object);
  }

  @override
  Future<Response> get(String url, dynamic object) async {
    return _request('get', url, object);
  }

  @override
  Future<Response> post(String url, dynamic object) async {
    return _request('post', url, object);
  }

  @override
  Future<Response> put(String url, dynamic object) async {
    return _request('put', url, object);
  }

  Future<Response> _request(String verb, String url, dynamic object) async {
    Client client = Client();

    Response responseRequest;
    if(verb == "put"){
      var body = object == null ? "" : json.encode(_convertJson(object));
      responseRequest = await client.put(Uri.parse(url), body: body, headers: _getHeader()).timeout(_getTimeOut());     
    }else if (verb == "post"){
      var body = object == null ? "" : json.encode(_convertJson(object));
      responseRequest = await client.post(Uri.parse(url), body: body, headers: _getHeader()).timeout(_getTimeOut());
    }else if(verb == "get"){
      var params = object == null ? "" : _getQueryString(_convertJson(object));
      responseRequest = await client.get(Uri.parse("$url?$params"), headers: _getHeader()).timeout(_getTimeOut());
    }else{
      var params = object == null ? "" : _getQueryString(_convertJson(object));
      responseRequest = await client.delete(Uri.parse("$url?$params"), headers: _getHeader()).timeout(_getTimeOut());
    }

    debugPrint('$url - ${responseRequest.statusCode}');

    return responseRequest;
  }

  Map<String, String> _getHeader() {
    Map<String, String> retorno = {
      "content-type": "application/json",
      "accept": "application/json"
    };
    return retorno;
  }
  
  Duration _getTimeOut(){
    return const Duration(seconds: 30);
  }

  dynamic _convertJson(dynamic object) {
    if(object == null ){
      return null;
    }
    try {
      return object.toMap();
    } catch (error) {
      return object;
    }
  }

  String _getQueryString(Map params, {String prefix = '&', bool inRecursion = false}) {
    String query = '';

    params.forEach((key, value) {
      if (inRecursion) {
        key = '[$key]';
      }

      if (value is String || value is int || value is double || value is bool) {
        query += '$prefix$key=$value';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query += _getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }

    });

    return query;
  }

}