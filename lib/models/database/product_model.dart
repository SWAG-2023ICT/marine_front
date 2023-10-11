import 'package:swag_marine_products/models/database/price_model.dart';

class ProductModel {
  int productId;
  String origin;
  String productName;
  List<int>? productImage;
  String description;
  bool productStatus;
  String storeId;
  int amount;
  List<PriceModel> prices;

  ProductModel({
    required this.productId,
    required this.origin,
    required this.productName,
    this.productImage,
    required this.description,
    required this.productStatus,
    required this.storeId,
    required this.amount,
    required this.prices,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as int,
      origin: json['origin'] as String,
      productName: json['productName'] as String,
      productImage: (json['productImage'] as List<int>?),
      description: json['description'] as String,
      productStatus: json['productStatus'] as bool,
      storeId: json['storeId'] as String,
      amount: json['amount'] as int,
      prices: (json['prices'] as List)
          .map((priceJson) => PriceModel.fromJson(priceJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'origin': origin,
      'productName': productName,
      'productImage': productImage,
      'description': description,
      'productStatus': productStatus,
      'storeId': storeId,
      'amount': amount,
      'prices': prices.map((price) => price.toJson()).toList(),
    };
  }
}
