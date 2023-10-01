import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _preferences;

  Future<SharedPreferences> _getPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();

    return _preferences!;
  }

  Future<Map<String, dynamic>?> getMap({
    required String key,
  }) async {
    final value = (await _getPreferences()).getString(key);

    if (value == null) {
      return null;
    }

    return jsonDecode(value);
  }

  Future<void> setMap({
    required String key,
    required Map<String, dynamic>? value,
  }) async {
    final preferences = await _getPreferences();

    if (value == null) {
      await preferences.remove(key);

      return;
    }

    await preferences.setString(key, jsonEncode(value));
  }
}
