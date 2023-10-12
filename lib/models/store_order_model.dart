import 'package:swag_marine_products/models/database/destination_model.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

class StoreOrderModel {
  int ordersId;
  String orderDtm;
  int totalPrice;
  String deliveryPhoneNumber;
  String deliveryTargetName;
  int deliveryStatus;
  int orderStatus;
  String? deliveryInvoice;
  String orderUserId;
  String? storeId;
  int destinationId;
  DestinationModel destination;
  List<ProductModel> products;

  StoreOrderModel({
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
    required this.destination,
    required this.products,
  });

  factory StoreOrderModel.fromJson(
      Map<String, dynamic> orderJson, Map<String, dynamic> destinationJson) {
    return StoreOrderModel(
      ordersId: orderJson['ordersId'] as int,
      orderDtm: orderJson['orderDtm'].toString(),
      totalPrice: orderJson['totalPrice'] as int,
      deliveryPhoneNumber: orderJson['deliveryPhoneNumber'] as String,
      deliveryTargetName: orderJson['deliveryTargetName'] as String,
      deliveryStatus: orderJson['deliveryStatus'] as int,
      orderStatus: orderJson['orderStatus'] as int,
      deliveryInvoice: orderJson['deliveryInvoice'] as String?,
      orderUserId: orderJson['orderUserId'] as String,
      storeId: orderJson['storeId'] as String?,
      destinationId: orderJson['destinationId'] as int,
      destination: DestinationModel.fromJson(destinationJson['destination']),
      products: (orderJson['products'] as List)
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
      'destination': destination.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
