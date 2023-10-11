import 'dart:typed_data';

import 'package:swag_marine_products/models/database/destination_model.dart';
import 'package:swag_marine_products/models/database/order_model.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

class StoreModel {
  String userId;
  String password;
  String name;
  String phoneNumber;
  String storeId;
  String storeName;
  String storePhoneNumber;
  String storeAddress;
  List<int>? storeImage;
  String sellerId;
  List<OrderModel> oreOrders;
  List<ProductModel> products;
  List<DestinationModel> destinations;

  StoreModel({
    required this.userId,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.storeId,
    required this.storeName,
    required this.storePhoneNumber,
    required this.storeAddress,
    this.storeImage,
    required this.sellerId,
    required this.oreOrders,
    required this.products,
    required this.destinations,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      storePhoneNumber: json['storePhoneNumber'] as String,
      storeAddress: json['storeAddress'] as String,
      storeImage: (json['storeImage'] as List<int>?),
      sellerId: json['sellerId'] as String,
      oreOrders: (json['oreOrders'] as List)
          .map((orderJson) => OrderModel.fromJson(orderJson))
          .toList(),
      products: (json['products'] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
      destinations: (json['destinations'] as List)
          .map((destinationJson) => DestinationModel.fromJson(destinationJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'storeId': storeId,
      'storeName': storeName,
      'storePhoneNumber': storePhoneNumber,
      'storeAddress': storeAddress,
      'storeImage': storeImage,
      'sellerId': sellerId,
      'oreOrders': oreOrders.map((order) => order.toJson()).toList(),
      'products': products.map((product) => product.toJson()).toList(),
      'destinations':
          destinations.map((destination) => destination.toJson()).toList(),
    };
  }
}
