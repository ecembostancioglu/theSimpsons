import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesimpsons/constants/text_constants.dart';

class RememberMeProvider extends ChangeNotifier {
  bool _isChecked = false;
  String _email = '';

  bool get isChecked => _isChecked;
  String get email => _email;

  RememberMeProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isChecked = prefs.getBool(TextConstants.remember_me) ?? false; //Kaydedilen rememberMe seçeneğini alır.
    _email = prefs.getString(TextConstants.email) ?? ''; //Kaydedilen emaili alır.
    notifyListeners(); //Dinleyicilere son durumu aktarır.
  }

  void setRememberMe(bool value, String email) async {
    final prefs = await SharedPreferences.getInstance();
    _isChecked = value;
    _email = value ? email : '';
    await prefs.setBool(TextConstants.remember_me, _isChecked); //RememberMe değerini kaydeder.
    await prefs.setString(TextConstants.email, _email); // Emaili kaydeder.
    notifyListeners();
  }
}
