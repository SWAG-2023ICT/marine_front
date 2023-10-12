class PriceModel {
  int? priceId;
  String unit;
  int priceByUnit;
  int? productId;

  PriceModel({
    this.priceId,
    required this.unit,
    required this.priceByUnit,
    this.productId,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    // JSON 데이터에서 필드 추출 및 파싱
    // priceId, unit, priceByUnit, productId 등의 필드를 파싱하여 Price 객체를 생성
    // 예: priceId는 List<int> 형태로 변환

    return PriceModel(
      priceId: json['priceId'] as int?,
      unit: json['unit'] as String,
      priceByUnit: json['priceByUnit'] as int,
      productId: json['productId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    // Price 객체를 JSON 데이터로 변환
    // 필드를 JSON 형식으로 변환하여 반환

    return {
      'priceId': priceId,
      'unit': unit,
      'priceByUnit': priceByUnit,
      'productId': productId,
    };
  }
}
