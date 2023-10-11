import 'package:flutter/material.dart';
import 'package:swag_marine_products/models/database/store_model.dart';

class StoreProvider extends ChangeNotifier {
  bool _isLogined = false;
  String? _storeId;

  bool get isLogined => _isLogined;
  String? get storeId => _storeId;

  Future<void> login(String storeId) async {
    _isLogined = true;
    _storeId = storeId;
    notifyListeners();
  }

  void logout() {
    _isLogined = false;
    _storeId = null;
    notifyListeners();
  }

  void updateUserData(String storeId) {
    _storeId = storeId;
    notifyListeners();
  }
}
