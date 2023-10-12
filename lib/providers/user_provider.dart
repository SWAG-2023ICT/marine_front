import 'package:flutter/material.dart';
import 'package:swag_marine_products/models/database/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogined = false;
  UserModel? _userData;
  int? _destinationId;

  bool get isLogined => _isLogined;
  UserModel? get userData => _userData;
  int? get destinationId => _destinationId;

  Future<void> login(UserModel userData, int destinationId) async {
    _isLogined = true;
    _userData = userData;
    _destinationId = destinationId;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLogined = false;
    _userData = null;
    notifyListeners();
  }

  Future<void> onChangeUserData(UserModel userData) async {
    _userData = userData;
    notifyListeners();
  }

  Future<void> onChangeAddressId(int destinationId) async {
    _destinationId = destinationId;
    notifyListeners();
  }
}
