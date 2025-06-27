import 'package:home_service/features/authentication/domain/entities/worker.dart';

class WorkerModel extends Worker {
  const WorkerModel({
    required int serviceId,
    required String description,
    required String fullName,
    String? companyName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String address,
    required String buildingNumber,
    required int cityId,
    required int experienceYears,
    String? profilePictureUrl,
  }) : super(
          serviceId: serviceId,
          description: description,
          fullName: fullName,
          companyName: companyName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phoneNumber: phoneNumber,
          address: address,
          buildingNumber: buildingNumber,
          cityId: cityId,
          experienceYears: experienceYears,
          profilePictureUrl: profilePictureUrl,
        );

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      serviceId: json['ServiceId'] ?? json['serviceId'],
      description: json['Description'] ?? json['description'],
      fullName: json['Name'] ?? json['fullName'] ?? '',
      companyName: json['CompanyName'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      confirmPassword: json['ConfirmPassword'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      address: json['Address'] ?? '',
      buildingNumber: json['BuildingNumber'] ?? '',
      cityId: json['CityId'] ?? 0,
      experienceYears: json['ExperienceYears'] ?? 0,
      profilePictureUrl: json['ProfilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': fullName, // or whatever field is for the user's name
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'buildingNumber': buildingNumber,
      'cityName': '', // probably not needed for update, but add if required
      'profilePictureUrl': profilePictureUrl ?? '',
      'serviceName': '', // fill if your app has it
      'description': description,
      'companyName': companyName ?? '',
      'experienceYears': experienceYears,
    };
  }

  Map<String, String> toFields() {
    return {
      'ServiceId': serviceId.toString(),
      'Description': description,
      'Name': fullName,
      'CompanyName': companyName ?? '',
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'BuildingNumber': buildingNumber,
      'CityId': cityId.toString(),
      'ExperienceYears': experienceYears.toString(),
      'ProfilePictureUrl': profilePictureUrl ?? '',
    };
  }
}
