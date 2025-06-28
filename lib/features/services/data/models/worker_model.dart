import '../../domain/entities/worker.dart';

class WorkerModel extends Worker {
  const WorkerModel({
    required int id,
    required String name,
    required String description,
    required int experienceYears,
    required String address,
    required String city,
    double? rating,
    String? profilePicture,
  }) : super(
    id: id,
    name: name,
    description: description,
    experienceYears: experienceYears,
    address: address,
    city: city,
    rating: rating,
    profilePicture: profilePicture,
  );

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      experienceYears: json['experienceYears'],
      address: json['address'],
      city: json['city'],
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      profilePicture: json['profilePicture'],
    );
  }
}
