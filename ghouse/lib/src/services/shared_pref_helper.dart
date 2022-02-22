import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences preferences  = await SharedPreferences.getInstance();

Future<String> readFromStorage({String key}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var value = preferences.getString(key);
  return value;
}

Future<int> readIntFromStorage({String key}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var value = preferences.getInt(key);
  return value;
}

Future<bool> readBoolFromStorage({String key}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var value = preferences.getBool(key);
  return value;
}

Future<bool> checkExisteince({String key}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (preferences.containsKey(key)) return true;
  return false;
}

Future<void> writeToStorage({String key, String value}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(key, value);
  print(preferences.getString(key));
}

Future<void> addBoolToStorage({String key, bool value}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool(key, value);
}

Future<void> writeIntToStorage({String key, int value}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt(key, value);
}

Future<void> clearTheStorage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  preferences.setBool('isLogedin', false);
}
