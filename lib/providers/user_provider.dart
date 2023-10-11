import 'package:flutter/material.dart';
import 'package:swag_marine_products/models/database/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogined = false;
  String? _userId;

  bool get isLogined => _isLogined;
  String? get userId => _userId;

  Future<void> login(String userId) async {
    _isLogined = true;
    _userId = userId;
    notifyListeners();
  }

  void logout() {
    _isLogined = false;
    _userId = null;
    notifyListeners();
  }
}
