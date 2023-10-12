import 'package:flutter/material.dart';
import 'package:swag_marine_products/models/database/store_model.dart';

class StoreProvider extends ChangeNotifier {
  bool _isLogined = false;
  String? _storeId;
  String? _userId;

  bool get isLogined => _isLogined;
  String? get storeId => _storeId;
  String? get userId => _userId;

  Future<void> login(String userId, String storeId) async {
    _isLogined = true;
    _userId = userId;
    _storeId = storeId;
    notifyListeners();
  }

  void logout() {
    _isLogined = false;
    _userId = null;
    _storeId = null;
    notifyListeners();
  }

  void updateUserData(String userId, String storeId) {
    _userId = userId;
    _storeId = storeId;
    notifyListeners();
  }
}
