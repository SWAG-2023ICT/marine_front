class MarineProduct {
  String dates;
  String mClassName;
  String sClassName;
  String gradeName;
  double avgPrice;
  double maxPrice;
  double minPrice;
  int sumAmt;
  String marketName;
  String coName;

  MarineProduct({
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
  factory MarineProduct.fromJson(Map<String, dynamic> json) {
    return MarineProduct(
      dates: json['DATES'] as String,
      mClassName: json['MCLASSNAME'] as String,
      sClassName: json['SCLASSNAME'] as String,
      gradeName: json['GRADENAME'] as String,
      avgPrice: (json['AVGPRICE'] as double),
      maxPrice: (json['MAXPRICE'] as double),
      minPrice: (json['MINPRICE'] as double),
      sumAmt: json['SUMAMT'] as int,
      marketName: json['MARKETNAME'] as String,
      coName: json['CONAME'] as String,
    );
  }

  // MarineProduct 객체를 JSON으로 직렬화하는 toJson 메소드
  Map<String, dynamic> toJson() {
    return {
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
