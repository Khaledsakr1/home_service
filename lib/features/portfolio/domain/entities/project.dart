import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> imageUrls;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrls];
}


