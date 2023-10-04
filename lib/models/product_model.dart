import 'dart:typed_data';

class ProductModel {
  final int productId;
  final String origin;
  final Uint8List productImage; // Uint8List는 바이트 데이터를 저장하는 데 사용됩니다.
  final String unit;
  final int priceByUnit;

  ProductModel({
    required this.productId,
    required this.origin,
    required this.productImage,
    required this.unit,
    required this.priceByUnit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'] as int,
      origin: json['origin'] as String,
      productImage: Uint8List.fromList(json['product_image'].cast<int>()),
      unit: json['unit'] as String,
      priceByUnit: json['price_by_unit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'origin': origin,
      'product_image': productImage.toList(),
      'unit': unit,
      'price_by_unit': priceByUnit,
    };
  }
}
