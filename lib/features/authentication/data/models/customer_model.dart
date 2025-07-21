import 'package:home_service/features/authentication/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String address,
    required String buildingNumber,
    required int cityId,
    int? age =0,
  }) : super(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phoneNumber: phoneNumber,
          address: address,
          buildingNumber: buildingNumber,
          cityId: cityId,
          age: age,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      buildingNumber: json['buildingNumber'],
      cityId: json['cityId'],
      age: json['age']?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phoneNumber': phoneNumber,
      'address': address,
      'buildingNumber': buildingNumber,
      'cityId': cityId,
      'age': age ?? 0,
    };
  }

  Map<String, String> toQueryParams() {
    final map = {
      'Name': name,
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'BuildingNumber': buildingNumber,
      'CityId': cityId.toString(),
    };

    if (age != null) {
      map['Age'] = age.toString();
    }
    return map;
  }
}
