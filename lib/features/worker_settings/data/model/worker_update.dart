
import 'package:home_service/features/worker_settings/domain/entities/worker_profile.dart';

class WorkerProfileUpdateModel extends WorkerProfileUpdate {
  const WorkerProfileUpdateModel({
    String? name,
    String? phoneNumber,
    String? address,
    String? buildingNumber,
    int? cityId,
    int? age,
    String? description,
    String? companyName,
    int? experienceYears,
    int? serviceId,
    String? email,
    String?  profilePictureUrl,
    String? cityName,
  }) : super(
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          buildingNumber: buildingNumber,
          cityId: cityId,
          age: age,
          description: description,
          companyName: companyName,
          experienceYears: experienceYears,
          serviceId: serviceId,
          email: email,
          profilePictureUrl: profilePictureUrl,
          cityName: cityName,
        );

  factory WorkerProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    return WorkerProfileUpdateModel(
      name: json['displayName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      buildingNumber: json['buildingNumber'],
      cityId: json['cityId'],
      age: json['age'],
      description: json['description'],
      companyName: json['companyName'],
      experienceYears: json['experienceYears'],
      serviceId: json['serviceId'],
      email: json['email'],
      profilePictureUrl: json['profilePictureUrl'],
      cityName: json['cityName'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (address != null) data['address'] = address;
    if (buildingNumber != null) data['buildingNumber'] = buildingNumber;
    if (cityId != null) data['cityId'] = cityId;
    if (age != null) data['age'] = age;
    if (description != null) data['description'] = description;
    if (companyName != null) data['companyName'] = companyName;
    if (experienceYears != null) data['experienceYears'] = experienceYears;
    if (serviceId != null) data['serviceId'] = serviceId;
    // if (email != null) data['email'] = email;
    // if (profilePictureUrl != null) data['profilePictureUrl'] = profilePictureUrl;
    return data;
  }

}
