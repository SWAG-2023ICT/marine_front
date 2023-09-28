import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyLoginDataId = "loginDataId";
  static const _keyLoginDataPw = "loginDataPw";
  static const _keyLoginDataType = "loginDataType";

  static Future saveLoginData(
      {required String id, required String pw, required bool isStored}) async {
    await storage.write(key: _keyLoginDataId, value: id);
    await storage.write(key: _keyLoginDataPw, value: pw);
    await storage.write(
        key: _keyLoginDataType, value: isStored ? "true" : "false");
  }

  static Future<List<String?>> getLoginData() async {
    final id = await storage.read(key: _keyLoginDataId);
    final pw = await storage.read(key: _keyLoginDataPw);
    final isStored = await storage.read(key: _keyLoginDataType);
    return [
      id,
      pw,
      isStored,
    ];
  }

  // 이메일을 비움
  static Future resetLoginData() async {
    await storage.delete(key: _keyLoginDataId);
    await storage.delete(key: _keyLoginDataPw);
    await storage.delete(key: _keyLoginDataType);
  }
}
