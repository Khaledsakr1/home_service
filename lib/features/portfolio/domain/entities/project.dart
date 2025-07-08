import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final List<int> imageIds; // Add this

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.imageIds, // Add this
  });

  @override
  List<Object?> get props => [id, name, description, imageUrls, imageIds];
}
