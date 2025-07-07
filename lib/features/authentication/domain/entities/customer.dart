import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String address;
  final String buildingNumber;
  final int cityId;
  final int? age;

  const Customer({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.address,
    required this.buildingNumber,
    required this.cityId,
    this.age,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        phoneNumber,
        address,
        buildingNumber,
        cityId,
        age,
      ];
}
