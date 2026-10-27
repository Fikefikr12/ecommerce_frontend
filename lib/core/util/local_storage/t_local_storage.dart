import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  // create object
  static final TLocalStorage _instance = TLocalStorage._internal();

  // return existing object
  factory TLocalStorage() => _instance;

  TLocalStorage._internal();

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Save data
  Future<void> saveData<T>(String key, T value) async {
    final prefs = await _prefs;

    switch (value) {
      case String():
        await prefs.setString(key, value);
        break;
      case int():
        await prefs.setInt(key, value);
        break;
      case double():
        await prefs.setDouble(key, value);
        break;
      case bool():
        await prefs.setBool(key, value);
        break;
      case List<String>():
        await prefs.setStringList(key, value);
        break;
      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }

  /// Read data
  Future<T?> readData<T>(String key) async {
    final prefs = await _prefs;
    return prefs.get(key) as T?;
  }

  /// Remove data
  Future<void> removeData(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  /// Clear all storage
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }
}
