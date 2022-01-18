import 'package:cotacao_moeda/model/coin_model.dart';
import 'package:cotacao_moeda/model/ocurrence_model.dart';

abstract class IOcurrenceService {
  Future<List<OcurrenceModel>> get(String coin);
  Future<List<OcurrenceModel>> closingDate(String coin, String startDate, String endDate);
  Future<List<OcurrenceModel>> sequencialDate(String coin, int count, String startDate, String endDate);
}