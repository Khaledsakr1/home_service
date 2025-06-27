import 'package:home_service/features/authentication/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required String email,
    required String password,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) : super(
          email: email,
          password: password,
          fullName: fullName,
          phoneNumber: phoneNumber,
          address: address,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  Map<String, String> toQueryParams() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName ?? '',
      'phoneNumber': phoneNumber ?? '',
      'address': address ?? '',
    };
  }
}


