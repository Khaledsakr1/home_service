import 'package:equatable/equatable.dart';

class WorkerProfileUpdate extends Equatable {
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? buildingNumber;
  final int? cityId;
  final int? age;
  final String? description;
  final String? companyName;
  final int? experienceYears;
  final int? serviceId;
  final String? email;
  final String? profilePictureUrl;
  final String? cityName;

  const WorkerProfileUpdate({
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.buildingNumber,
    this.cityId,
    this.age,
    this.description,
    this.companyName,
    this.experienceYears,
    this.serviceId,
    this.profilePictureUrl,
    this.cityName,
  });

  @override
  List<Object?> get props => [
    name,
    phoneNumber,
    address,
    buildingNumber,
    cityId,
    age,
    description,
    companyName,
    experienceYears,
    serviceId,
    email,
    profilePictureUrl,
    cityName,
  ];
}
