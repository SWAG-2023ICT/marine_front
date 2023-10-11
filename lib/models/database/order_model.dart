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
  String storeId;
  int destinationId;
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
    required this.storeId,
    required this.destinationId,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      ordersId: json['ordersId'] as int,
      orderDtm: json['orderDtm'] as String,
      totalPrice: json['totalPrice'] as int,
      deliveryPhoneNumber: json['deliveryPhoneNumber'] as String,
      deliveryTargetName: json['deliveryTargetName'] as String,
      deliveryStatus: json['deliveryStatus'] as int,
      orderStatus: json['orderStatus'] as int,
      deliveryInvoice: json['deliveryInvoice'] as String?,
      orderUserId: json['orderUserId'] as String,
      storeId: json['storeId'] as String,
      destinationId: json['destinationId'] as int,
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
      'destinationId': destinationId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
