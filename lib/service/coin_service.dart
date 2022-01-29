import 'dart:convert';

import 'package:cotacao_moeda/controller/application_controller.dart';
import 'package:cotacao_moeda/controller/request_controller.dart';
import 'package:cotacao_moeda/interface/service/icoin_service.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoinService implements ICoinService {

  @override
  Future<List<CoinModel>> getAll() async {
    String data = await rootBundle.loadString('assets/coin.json');
    var coinList = (json.decode(data) as List).map((e) => CoinModel.fromJson(e)).toList();
    for(var coin in coinList){
      coin.image = "assets/flag/${coin.image}";
    }
    return coinList;
  }

  @override
  Future<CoinModel?> getAbout(CoinModel coin) async {
    var _coinTag = coin.name.split("-")[0];
    coin.about = await rootBundle.loadString('assets/about/$_coinTag.txt');
    return coin;
  }

}