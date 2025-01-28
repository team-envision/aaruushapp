import 'package:get_storage/get_storage.dart';

class LocalClient {
  static final GetStorage _storage = GetStorage();

  /// Save a value to storage
  static Future<void> saveValue({
    required String key,
    required dynamic value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve a value from storage
  static T? getValue<T>({
    required String key,
    T? defaultValue,
  }) {
    return _storage.read<T>(key) ?? defaultValue;
  }

  /// Remove a value from storage
  static Future<void> removeValue({
    required String key,
  }) async {
    await _storage.remove(key);
  }

  /// Check if a key exists in storage
  static bool hasKey({
    required String key,
  }) {
    return _storage.hasData(key);
  }

  /// Clear all data from storage
  static Future<void> clearAll() async {
    await _storage.erase();
  }

  /// Save a list to storage
  static Future<void> saveList({
    required String key,
    required List<dynamic> value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve a list from storage
  static List<dynamic>? getList({
    required String key,
    List<dynamic>? defaultValue,
  }) {
    return _storage.read<List<dynamic>>(key) ?? defaultValue;
  }

  /// Save a boolean value to storage
  static Future<void> saveBool({
    required String key,
    required bool value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve a boolean value from storage
  static bool getBool({
    required String key,
    bool defaultValue = false,
  }) {
    return _storage.read<bool>(key) ?? defaultValue;
  }

  /// Save an integer value to storage
  static Future<void> saveInt({
    required String key,
    required int value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve an integer value from storage
  static int getInt({
    required String key,
    int defaultValue = 0,
  }) {
    return _storage.read<int>(key) ?? defaultValue;
  }

  /// Save a double value to storage
  static Future<void> saveDouble({
    required String key,
    required double value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve a double value from storage
  static double getDouble({
    required String key,
    double defaultValue = 0.0,
  }) {
    return _storage.read<double>(key) ?? defaultValue;
  }

  /// Save a String value to storage
  static Future<void> saveString({
    required String key,
    required String value,
  }) async {
    await _storage.write(key, value);
  }

  /// Retrieve a String value from storage
  static String getString({
    required String key,
    String defaultValue = '',
  }) {
    return _storage.read<String>(key) ?? defaultValue;
  }
}
