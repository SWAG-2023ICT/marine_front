class RadioactivityBannerModel {
  DateTime dailyDate;
  int dailyPassCnt;
  int dailyFailCnt;
  int dailyTotCnt;

  RadioactivityBannerModel({
    required this.dailyDate,
    required this.dailyPassCnt,
    required this.dailyFailCnt,
    required this.dailyTotCnt,
  });

  factory RadioactivityBannerModel.fromJson(Map<String, dynamic> json) {
    return RadioactivityBannerModel(
      dailyDate: DateTime.parse(json['dailyDate']),
      dailyPassCnt: json['dailyPassCnt'] as int,
      dailyFailCnt: json['dailyFailCnt'] as int,
      dailyTotCnt: json['dailyTotCnt'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'dailyDate': dailyDate,
      'dailyPassCnt': dailyPassCnt,
      'dailyFailCnt': dailyFailCnt,
      'dailyTotCnt': dailyTotCnt,
    };
    return data;
  }
}
