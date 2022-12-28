import 'package:shared_preferences/shared_preferences.dart';

import '../Models/products_model.dart';

List<Product> productData = [];
List<dynamic> favProd = [];
List<Product> myProd = [];

class SharedStorage {
  static const _keyName = "Username";
  static const _keyPhone = "PhoneNumber";

  static SharedPreferences? _prefStorage;

  static Future init() async =>
      _prefStorage = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _prefStorage!.setString(_keyName, username);

  static Future setPhoneNumber(String phoneNumber) async =>
      await _prefStorage!.setString(_keyPhone, phoneNumber);

  static String getUserName() => _prefStorage!.getString(_keyName) ?? '';

  static String getPhoneNumber() => _prefStorage!.getString(_keyPhone) ?? '';
}
