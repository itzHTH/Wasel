import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasel_core/const/app_constants.dart';

class AppLocalCache {
  // private constructor as I don't want to allow creating an instance of this class itself.
  AppLocalCache._();

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    if (AppConstants.isDebug) {
      debugPrint(
        '💾 SharedPrefHelper | data with key :  $key has been removed',
      );
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<void> clearAllData() async {
    if (AppConstants.isDebug) {
      debugPrint('💾 SharedPrefHelper | all data has been cleared');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<bool> setData(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (AppConstants.isDebug) {
      debugPrint(
        "💾 SharedPrefHelper | setData with key : $key and value : $value",
      );
    }

    switch (value) {
      case String _:
        return await sharedPreferences.setString(key, value);
      case int _:
        return await sharedPreferences.setInt(key, value);
      case bool _:
        return await sharedPreferences.setBool(key, value);
      case double _:
        return await sharedPreferences.setDouble(key, value);
      default:
        if (AppConstants.isDebug) {
          debugPrint(
            "💾 SharedPrefHelper | Unsupported type for value : $value",
          );
        }
        return false;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool?> getBool(String key) async {
    if (AppConstants.isDebug) {
      debugPrint('💾 SharedPrefHelper | getBool with key : $key');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    if (AppConstants.isDebug) {
      debugPrint('💾 SharedPrefHelper | getDouble with key : $key');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    if (AppConstants.isDebug) {
      debugPrint('💾 SharedPrefHelper | getInt with key : $key');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    if (AppConstants.isDebug) {
      debugPrint('💾 SharedPrefHelper | getString with key : $key');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    if (AppConstants.isDebug) {
      debugPrint(
        "🔐 FlutterSecureStorage | setSecuredString with key : $key and value : $value",
      );
    }
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static Future<String?> getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    if (AppConstants.isDebug) {
      debugPrint('🔐 FlutterSecureStorage | getSecuredString with key : $key');
    }
    return await flutterSecureStorage.read(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    if (AppConstants.isDebug) {
      debugPrint('🔐 FlutterSecureStorage | all data has been cleared');
    }
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
