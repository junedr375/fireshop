import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences localStorageInstance;

class AppStorageKeys {
  static const isLoggedIn = 'isLoggedIn';
}

class AppStorage {
  static Future<bool> setBool(String key, bool value) async {
    return localStorageInstance.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    return localStorageInstance.getBool(key) ?? false;
  }

  static Future<bool> removeBool(String key) async {
    return localStorageInstance.remove(key);
  }
}
