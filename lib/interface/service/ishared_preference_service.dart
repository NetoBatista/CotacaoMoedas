abstract class ISharedPreferenceService {
  Future postString(String key, String value);
  Future<String?> getString(String key);
  Future remove(String key);
}