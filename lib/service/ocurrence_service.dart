import 'dart:convert';

import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:cotacao_moeda/controller/request_controller.dart';
import 'package:cotacao_moeda/interface/service/iocurrence_service.dart';
import 'package:cotacao_moeda/model/ocurrence_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OcurrenceService implements IOcurrenceService {
  final RequestController _requestController = Modular.get<RequestController>();
  final ApplicationController _applicationController = Modular.get<ApplicationController>();

  @override
  Future<List<OcurrenceModel>> get(String coin) async {
    var response = await _requestController.get("${_applicationController.urlApi}/last/$coin", null);
    if(response.statusCode != 200) {
      return [];
    }

    var responseList = <OcurrenceModel>[];
    var jsonResponse = json.decode(response.body);
    for(var _coin in coin.split(",")){
      var valueCoin = jsonResponse[_coin.split("-")[0]];
      responseList.add(OcurrenceModel.fromJson(valueCoin));
    }

    return responseList;

  }

  @override
  Future<List<OcurrenceModel>> closingDate(String coin, String startDate, String endDate) async {
    var response = await _requestController.get("${_applicationController.urlApi}/json/daily/$coin/?start_date=$startDate&end_date=$endDate", null);
    if(response.statusCode == 200){
      return (json.decode(response.body) as List).map((e) => OcurrenceModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<OcurrenceModel>> sequencialDate(String coin, int count, String startDate, String endDate) async {
     var response = await _requestController.get("${_applicationController.urlApi}/$coin/$count?start_date=$startDate&end_date=$endDate", null);
    if(response.statusCode == 200){
      return (json.decode(response.body) as List).map((e) => OcurrenceModel.fromJson(e)).toList();
    }

    return [];
  }

}