
import 'package:cotacao_moeda/interface/service/ishared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService implements ISharedPreferenceService {
  @override
  Future<String?> getString(String key) async  {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString(key);
  }

  @override
  Future postString(String key, String value) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.setString(key, value);
  }

  @override
  Future remove(String key) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

}