abstract class IRemoteConfig {
  Future<bool> initRemoteConfig();
  String getString({required String key});
  double getDouble(String key);
  int getInt(String key);
  bool getBool(String key);
}