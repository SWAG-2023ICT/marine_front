import 'package:swag_marine_products/models/database/destination_model.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

class OrderModel {
  int ordersId;
  String orderDtm;
  int totalPrice;
  String deliveryPhoneNumber;
  String deliveryTargetName;
  int deliveryStatus;
  int orderStatus;
  String? deliveryInvoice;
  String orderUserId;
  String? reason;
  String? storeId;
  int destinationId;
  DestinationModel destination;
  List<ProductModel> products;

  OrderModel({
    required this.ordersId,
    required this.orderDtm,
    required this.totalPrice,
    required this.deliveryPhoneNumber,
    required this.deliveryTargetName,
    required this.deliveryStatus,
    required this.orderStatus,
    this.deliveryInvoice,
    required this.orderUserId,
    required this.reason,
    required this.storeId,
    required this.destinationId,
    required this.destination,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      ordersId: json['ordersId'] as int,
      orderDtm: json['orderDtm'].toString(),
      totalPrice: json['totalPrice'] as int,
      deliveryPhoneNumber: json['deliveryPhoneNumber'] as String,
      deliveryTargetName: json['deliveryTargetName'] as String,
      deliveryStatus: json['deliveryStatus'] as int,
      orderStatus: json['orderStatus'] as int,
      deliveryInvoice: json['deliveryInvoice'] as String?,
      orderUserId: json['orderUserId'] as String,
      storeId: json['storeId'] as String?,
      reason: json['reason'] as String?,
      destinationId: json['destinationId'] as int,
      destination: DestinationModel.fromJson(json['destination']),
      products: (json['products'] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ordersId': ordersId,
      'orderDtm': orderDtm,
      'totalPrice': totalPrice,
      'deliveryPhoneNumber': deliveryPhoneNumber,
      'deliveryTargetName': deliveryTargetName,
      'deliveryStatus': deliveryStatus,
      'orderStatus': orderStatus,
      'deliveryInvoice': deliveryInvoice,
      'orderUserId': orderUserId,
      'storeId': storeId,
      'reason': reason,
      'destinationId': destinationId,
      'destination': destination.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
