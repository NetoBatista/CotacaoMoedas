import 'dart:convert';

import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:cotacao_moeda/controller/request_controller.dart';
import 'package:cotacao_moeda/interface/service/icoin_service.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoinService implements ICoinService {
  final RequestController _requestController = Modular.get<RequestController>();
  final ApplicationController _applicationController = Modular.get<ApplicationController>();

  @override
  Future<List<CoinModel>> getAll() async {
    var response = await _requestController.get("${_applicationController.urlApi}/coin", null);
    if(response.statusCode == 200){
      return (json.decode(response.body) as List).map((e) => CoinModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<CoinModel?> getAbout(CoinModel coin) async {
    var response = await _requestController.get("${_applicationController.urlApi}/coin/about", coin);
    if(response.statusCode == 200){
      return CoinModel.fromJson(json.decode(response.body));
    }

    return null;
  }

}