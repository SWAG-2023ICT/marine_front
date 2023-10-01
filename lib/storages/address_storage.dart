import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddressStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyAddressList = "addressList";

  static Future saveAddressList({required Map<String, String> newData}) async {
    if (newData.keys.first.isEmpty || newData.values.first.isEmpty) return;

    final addressList = await storage.read(key: _keyAddressList);
    List<Map<String, String>> data = [];

    if (addressList != null) {
      // 저장된 데이터가 있다면 역직렬화하여 data에 추가
      data = (jsonDecode(addressList) as List<dynamic>)
          .map((item) => Map<String, String>.from(item))
          .toList();
    }

    // 새로운 데이터 추가
    data.add({newData.keys.first: newData.values.first});

    // data를 JSON 형식으로 직렬화하여 저장
    await storage.write(key: _keyAddressList, value: jsonEncode(data));
  }

  static Future<List<Map<String, String>>> getAddressList() async {
    final addressList = await storage.read(key: _keyAddressList);
    if (addressList == null) return [];
    final data = jsonDecode(addressList) as List<dynamic>;

    // Map<String, dynamic>을 Map<String, String>으로 변환
    final typedData = data.map((item) {
      return Map<String, String>.from(item.cast<String, String>());
    }).toList();

    return typedData;
  }

  static Future<void> removeAddressList(String key) async {
    final addressList = await storage.read(key: _keyAddressList);
    List<Map<String, String>> data = [];

    if (addressList != null) {
      // 저장된 데이터가 있다면 역직렬화하여 data에 추가
      data = (jsonDecode(addressList) as List<dynamic>)
          .map((item) => Map<String, String>.from(item.cast<String, String>()))
          .toList();
    }

    // 이전 데이터에서 주어진 키와 일치하는 데이터 삭제
    data.removeWhere((item) => item.containsKey(key));

    await storage.write(key: _keyAddressList, value: jsonEncode(data));
  }

  static Future<void> updateAddress(
      {required String key, required Map<String, String> newData}) async {
    if (newData.keys.first.isEmpty || newData.values.first.isEmpty) return;

    final addressList = await storage.read(key: _keyAddressList);
    List<Map<String, String>> data = [];

    if (addressList != null) {
      // 저장된 데이터가 있다면 역직렬화하여 data에 추가
      data = (jsonDecode(addressList) as List<dynamic>)
          .map((item) => Map<String, String>.from(item.cast<String, String>()))
          .toList();
    }

    // 이전 데이터에서 주어진 키와 일치하는 데이터 삭제
    data.removeWhere((item) => item.containsKey(key));

    // 새로운 데이터 추가
    data.add({newData.keys.first: newData.values.first});

    // data를 JSON 형식으로 직렬화하여 저장
    await storage.write(key: _keyAddressList, value: jsonEncode(data));
  }

  // 주소 리스트를 비움
  static Future resetAddressList() async {
    await storage.delete(key: _keyAddressList);
  }
}
