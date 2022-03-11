import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> saveData({
    @required String key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getdata({
    @required String key,
  }) {
    return sharedPreferences.get(key);
  }
}

// Center(
// child: Text(
// 'الصلاه القادمه :${NextSala[1]} '
// ''
// ,
// // overflow: TextOverflow.ellipsis,
// style: TextStyle(
// color: Colors.white,
// fontFamily: 'Amiri',
// fontSize: 18,
// fontWeight: FontWeight.w700,
// ),
// ),
// ),