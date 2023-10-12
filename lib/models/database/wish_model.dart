class WishModel {
  int wishId;
  String storeId;
  String userId;

  WishModel({
    required this.wishId,
    required this.storeId,
    required this.userId,
  });

  factory WishModel.fromJson(Map<String, dynamic> json) {
    return WishModel(
      wishId: json['wishId'] as int,
      storeId: json['storeId'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wishId': wishId,
      'storeId': storeId,
      'userId': userId,
    };
  }
}
