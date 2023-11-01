import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mokataa/utils/remote_config/i_remote_config.dart';

class RemoteConfigImplementation extends IRemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Future<bool> initRemoteConfig() {
    remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration()
        )
    );
    return remoteConfig.fetchAndActivate();
  }

  @override
  String getString({required String key}) {
    return remoteConfig.getString(key);
  }

  @override
  bool getBool(String key) {
    return remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return remoteConfig.getInt(key);
  }
}