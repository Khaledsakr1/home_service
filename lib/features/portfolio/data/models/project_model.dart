import 'package:home_service/features/portfolio/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required int id,
    required String name,
    required String description,
    required List<String> imageUrls,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrls: imageUrls,
        );

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrls: (json['imageUrls'] as List)
        .map((img) => img['imageUrl'] as String)
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
    };
  }
}


