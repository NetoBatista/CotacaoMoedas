import 'package:cotacao_moeda/model/coin_model.dart';

abstract class ICoinService {
  Future<List<CoinModel>> getAll();
  Future<CoinModel?> getAbout(CoinModel coin);
}