import 'package:swag_marine_products/models/database/destination_model.dart';

class UserModel {
  String userId;
  String password;
  String name;
  String phoneNumber;
  List<DestinationModel> destinations;

  UserModel({
    required this.userId,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.destinations,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      destinations: (json['destinations'] as List)
          .map((destinationJson) => DestinationModel.fromJson(destinationJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'destinations':
          destinations.map((destination) => destination.toJson()).toList(),
    };
  }
}
