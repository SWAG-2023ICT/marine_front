class RadioactivityListModel {
  String itmNm; // 이름
  DateTime gathDt; // 채취일자
  String ogLoc; // 원산지
  String analMchnNm; // 분석지역
  String charPsngVal; // 문자합격값

  RadioactivityListModel({
    required this.itmNm,
    required this.gathDt,
    required this.ogLoc,
    required this.analMchnNm,
    required this.charPsngVal,
  });

  factory RadioactivityListModel.fromJson(Map<String, dynamic> json) {
    return RadioactivityListModel(
      itmNm: json['itmNm'] as String,
      gathDt: DateTime.parse(json['gathDt']),
      ogLoc: json['ogLoc'] as String,
      analMchnNm: json['analMchnNm'] as String,
      charPsngVal: json['charPsngVal'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'itmNm': itmNm,
      'gathDt': gathDt.toIso8601String(), // DateTime을 ISO 8601 문자열로 변환
      'ogLoc': ogLoc,
      'analMchnNm': analMchnNm,
      'charPsngVal': charPsngVal,
    };
    return data;
  }
}
