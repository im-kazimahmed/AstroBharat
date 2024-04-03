import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  PreferenceUtils.setMockInitialValues();
  static Future<SharedPreferences> get _instance async => sp = await SharedPreferences.getInstance();
  static SharedPreferences? sp;

  static Future<SharedPreferences?> init() async {
    sp = await _instance;
    return sp;
  }

  static String getString(String key, [String? defValue]) {
    return sp?.getString(key) ?? defValue ?? "";
  }
  static int? getint(String key, [int? defValue]) {
    return sp?.getInt(key) ?? defValue ?? 0;
  }
  static bool? getbool(String key, [bool? defValue]) {
    return sp?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }
  static Future<bool> setint(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }
  static Future<bool> setbool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<void> clear() async {
    await sp?.clear();
  }
  static void remove(String key) async {
    sp?.remove(key);
  }
}