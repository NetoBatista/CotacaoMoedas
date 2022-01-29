import 'package:cotacao_moeda/constants/shared_preference_constant.dart';
import 'package:cotacao_moeda/interface/service/icoin_service.dart';
import 'package:cotacao_moeda/interface/service/ishared_preference_service.dart';
import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/service/coin_service.dart';
import 'package:cotacao_moeda/service/shared_preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutCoinPageController {
  final ICoinService _coinService = Modular.get<CoinService>();
  final ISharedPreferenceService _sharedPreferenceService = Modular.get<SharedPreferenceService>();

  ValueNotifier<bool> getAbout = ValueNotifier<bool>(false);
  ValueNotifier<DateTime> refreshButtons = ValueNotifier<DateTime>(DateTime.now());
  String? coinFixed;

  Future init(CoinModel coinModel) async {
    getAbout.value = true;

    if(coinModel.about == null){
      await getAboutCoin(coinModel);
    }

    await getCoinFixed();

    getAbout.value = false;
    refreshButtons.value = DateTime.now();
  }

  bool coinIsFixed(CoinModel coinModel) => coinModel.name == coinFixed;

  Future getCoinFixed() async {
    coinFixed = await _sharedPreferenceService.getString(SharedPreferenceConstant.coinPinned);
  }

  Future getAboutCoin(CoinModel coinModel) async {
    var response = await _coinService.getAbout(coinModel);
    if(response != null){
      coinModel.about = response.about;
    }
  }

  Future pinCoin(CoinModel coinModel) async {
    await _sharedPreferenceService.postString(SharedPreferenceConstant.coinPinned, coinModel.name);
    await getCoinFixed();
    refreshButtons.value = DateTime.now();
  }

  Future unPinCoin() async {
    await _sharedPreferenceService.remove(SharedPreferenceConstant.coinPinned);
    await getCoinFixed();
    refreshButtons.value = DateTime.now();
  }

}