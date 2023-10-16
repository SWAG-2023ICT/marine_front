class MarketPriceModel {
  int rowNum;
  DateTime dates;
  String mClassName;
  String sClassName;
  String gradeName;
  int avgPrice;
  int maxPrice;
  int minPrice;
  int sumAmt;
  String marketName;
  String coName;

  MarketPriceModel({
    required this.rowNum,
    required this.dates,
    required this.mClassName,
    required this.sClassName,
    required this.gradeName,
    required this.avgPrice,
    required this.maxPrice,
    required this.minPrice,
    required this.sumAmt,
    required this.marketName,
    required this.coName,
  });

  // JSON 데이터를 MarineProduct 객체로 변환하는 fromJson 생성자
  factory MarketPriceModel.fromJson(Map<String, dynamic> json) {
    return MarketPriceModel(
      rowNum: json['ROW_NUM'] as int,
      dates: DateTime.parse(json['DATES']),
      mClassName: json['MCLASSNAME'] as String,
      sClassName: json['SCLASSNAME'] as String,
      gradeName: json['GRADENAME'] as String,
      avgPrice: (json['AVGPRICE'] as int),
      maxPrice: (json['MAXPRICE'] as int),
      minPrice: (json['MINPRICE'] as int),
      sumAmt: json['SUMAMT'] as int,
      marketName: json['MARKETNAME'] as String,
      coName: json['CONAME'] as String,
    );
  }

  // MarineProduct 객체를 JSON으로 직렬화하는 toJson 메소드
  Map<String, dynamic> toJson() {
    return {
      'ROW_NUM': rowNum,
      'DATES': dates,
      'MCLASSNAME': mClassName,
      'SCLASSNAME': sClassName,
      'GRADENAME': gradeName,
      'AVGPRICE': avgPrice,
      'MAXPRICE': maxPrice,
      'MINPRICE': minPrice,
      'SUMAMT': sumAmt,
      'MARKETNAME': marketName,
      'CONAME': coName,
    };
  }
}
