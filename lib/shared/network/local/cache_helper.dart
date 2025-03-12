import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putData({
    required String key,
    required dynamic data
  }) async {
    if (data is String) return await sharedPreferences?.setString(key, data);
    if (data is int) return await sharedPreferences?.setInt(key, data);
    if (data is bool) return await sharedPreferences?.setBool(key, data);

    return await sharedPreferences?.setDouble(key, data);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }

  static Future<bool?> removeData({required String key}) async {
    return await sharedPreferences?.remove(key);
  }
}
