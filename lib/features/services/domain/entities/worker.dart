import 'package:equatable/equatable.dart';

class Worker extends Equatable {
  final int id;
  final String name;
  final String description;
  final int experienceYears;
  final String address;
  final String city;
  final double? rating;
  final String? profilePicture;

  const Worker({
    required this.id,
    required this.name,
    required this.description,
    required this.experienceYears,
    required this.address,
    required this.city,
    this.rating,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [id, name, description, experienceYears, address, city, rating, profilePicture];
}
