class DestinationModel {
  int destinationId;
  int zipCode;
  String destinationName;
  String destinationAddress;
  bool defaultStatus;
  String userId;

  DestinationModel({
    required this.destinationId,
    required this.zipCode,
    required this.destinationName,
    required this.destinationAddress,
    required this.defaultStatus,
    required this.userId,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      destinationId: json['destinationId'] as int,
      zipCode: json['zipCode'] as int,
      destinationName: json['destinationName'] as String,
      destinationAddress: json['destinationAddress'] as String,
      defaultStatus: json['defaultStatus'] as bool,
      userId: json['userId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destinationId': destinationId,
      'zipCode': zipCode,
      'destinationName': destinationName,
      'destinationAddress': destinationAddress,
      'defaultStatus': defaultStatus,
      'userId': userId,
    };
  }
}
