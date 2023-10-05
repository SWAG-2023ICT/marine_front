import 'dart:typed_data';

class StoreModel {
  final int storeId;
  final String storeName;
  final String storePhoneNumber;
  final String storeAddress;
  final Uint8List storeImage;

  StoreModel({
    required this.storeId,
    required this.storeName,
    required this.storePhoneNumber,
    required this.storeAddress,
    required this.storeImage,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      storeId: json['store_id'] as int,
      storeName: json['store_name'] as String,
      storePhoneNumber: json['store_phone_number'] as String,
      storeAddress: json['store_address'] as String,
      storeImage: Uint8List.fromList(json['store_image'].cast<int>()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'store_name': storeName,
      'store_phone_number': storePhoneNumber,
      'store_address': storeAddress,
      'store_image': storeImage.toList(),
    };
  }
}
