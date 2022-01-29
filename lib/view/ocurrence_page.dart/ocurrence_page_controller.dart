import 'package:cotacao_moeda/interface/service/icoin_service.dart';
import 'package:cotacao_moeda/interface/service/iocurrence_service.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/model/ocurrence_model.dart';
import 'package:cotacao_moeda/service/coin_service.dart';
import 'package:cotacao_moeda/service/ocurrence_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OcurrencePageController {
  ValueNotifier<bool> searchOcurrence = ValueNotifier<bool>(false);
  ValueNotifier<DateTime> refreshList = ValueNotifier<DateTime>(DateTime.now());
  
  List<CoinModel> listAllCoin = <CoinModel>[];
  List<CoinModel> listCoinFiltered = <CoinModel>[];
  List<OcurrenceModel> listAllOcurrence = <OcurrenceModel>[];

  final ICoinService _coinService = Modular.get<CoinService>();
  final IOcurrenceService _ocurrenceService = Modular.get<OcurrenceService>();

  TextEditingController nameCoinController = TextEditingController();

  Future init() async {
    searchOcurrence.value = true;
    await getAllCoins();
    sortCoin();
    await getOcurrences();
    filterCoinByName(nameCoinController.text);
    searchOcurrence.value = false;
  }

  Future getAllCoins() async {
    listAllCoin.clear();
    var response = await _coinService.getAll();
    listAllCoin.addAll(response);
  }

  void sortCoin(){
    listAllCoin.sort((a, b) => a.description.compareTo(b.description));
  }

  Future getOcurrences() async {
    List<String> listCoinName = <String>[];
    for(var coin in listAllCoin){
      listCoinName.add(coin.name);
    }

    listAllOcurrence.clear();
    var response = await _ocurrenceService.get(listCoinName.join(","));
    listAllOcurrence.addAll(response);
  }

  OcurrenceModel getOcurrenceByCoin(String coinName) => listAllOcurrence.firstWhere((element) => coinName == "${element.code}-${element.codein}");

  void filterCoinByName(String coinName){
    listCoinFiltered.clear();

    if(coinName.trim().length == 0){
      listCoinFiltered.addAll(listAllCoin);
      refreshList.value = DateTime.now();
      return;
    }

    for(var coin in listAllCoin){
      var descriptionWithoutAccents = removeAccents(coin.description);     

      if(descriptionWithoutAccents.toLowerCase().contains(removeAccents(coinName).toLowerCase())){
        listCoinFiltered.add(coin);
      }
    }

    refreshList.value = DateTime.now();
  }

  String removeAccents(String value){
    String accents = "ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç";
    String withoutAccents = "AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc";
    for (int i = 0; i < accents.length; i++) {      
      value = value.replaceAll(accents[i], withoutAccents[i]);
    }
    return value;
  }
}