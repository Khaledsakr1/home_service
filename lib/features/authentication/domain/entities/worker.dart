import 'package:equatable/equatable.dart';

class Worker extends Equatable {
  final int serviceId;
  final String description;
  final String fullName;
  final String? companyName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String address;
  final String buildingNumber;
  final int cityId;
  final int experienceYears;
  final String? profilePictureUrl;

  const Worker({
    required this.serviceId,
    required this.description,
    required this.fullName,
    this.companyName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.address,
    required this.buildingNumber,
    required this.cityId,
    required this.experienceYears,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [
        serviceId,
        description,
        fullName,
        companyName,
        email,
        password,
        confirmPassword,
        phoneNumber,
        address,
        buildingNumber,
        cityId,
        experienceYears,
        profilePictureUrl,
      ];
}
