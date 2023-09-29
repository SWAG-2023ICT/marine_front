import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddressStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyAddressList = "addressList";

  static Future saveAddressList({required List<String> addressList}) async {
    await storage.write(key: _keyAddressList, value: addressList.toString());
  }

  static Future<List<String?>> getAddressList() async {
    final addressList =
        await storage.read(key: _keyAddressList) as List<String>;
    return addressList;
  }

  // 주소 리스트를 비움
  static Future resetAddressList() async {
    await storage.delete(key: _keyAddressList);
  }
}
