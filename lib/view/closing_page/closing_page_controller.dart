import 'package:cotacao_moeda/interface/service/icoin_service.dart';
import 'package:cotacao_moeda/interface/service/iocurrence_service.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/model/ocurrence_model.dart';
import 'package:cotacao_moeda/service/coin_service.dart';
import 'package:cotacao_moeda/service/ocurrence_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class ClosingPageController {
  final ICoinService _coinService = Modular.get<CoinService>();
  final IOcurrenceService _ocurrenceService = Modular.get<OcurrenceService>();

  List<CoinModel> listAllCoin = <CoinModel>[];
  List<OcurrenceModel> listAllOcurrence = <OcurrenceModel>[];

  ValueNotifier<DateTime> refreshDropDown = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<bool> getCoins = ValueNotifier<bool>(false);
  ValueNotifier<bool> getOcurrence = ValueNotifier<bool>(false);
  ValueNotifier<bool> canBeSearch = ValueNotifier<bool>(false);

  TextEditingController startMonthController = TextEditingController();
  TextEditingController endMonthController = TextEditingController();
  
  CoinModel? coinSelected;
  DateTime? startDateSelected;
  DateTime? endDateSelected;

  Future init() async {
    getCoins.value = true;
    await getAllCoins();
    sortCoin();
    getCoins.value = false;
  }

  OcurrenceModel getOcurrenceByCoin(String coinName) => listAllOcurrence.firstWhere((element) => coinName == "${element.code}-${element.codein}");

  void verifyCanBeSearch(){
    if(startDateSelected == null){
      canBeSearch.value = false;
      return;
    }

    if(endDateSelected == null){
      canBeSearch.value = false;
      return;
    }

    if(coinSelected == null){
      canBeSearch.value = false;
      return;
    }

    canBeSearch.value = true;
  }
  
  Future getAllCoins() async {
    listAllCoin.clear();
    var response = await _coinService.getAll();
    listAllCoin.addAll(response);
  }

  void sortCoin(){
    listAllCoin.sort((a, b) => a.description.compareTo(b.description));
  }

  Future getClosingOcurrence() async {
    getOcurrence.value = true;

    var startDate = DateFormat("yyyyMMdd", "ptBR").format(DateTime(startDateSelected?.year as int, startDateSelected?.month as int, 1));
    var endDate = DateFormat("yyyyMMdd", "ptBR").format(DateTime(endDateSelected?.year as int, endDateSelected?.month as int, 1));
    listAllOcurrence.clear();
    var response = await _ocurrenceService.closingDate((coinSelected?.name).toString(), startDate, endDate);
    listAllOcurrence.addAll(response);

    getOcurrence.value = false;
  }

}