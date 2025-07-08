import 'package:home_service/features/portfolio/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required int id,
    required String name,
    required String description,
    required List<String> imageUrls,
    required List<int> imageIds,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrls: imageUrls,
          imageIds: imageIds
        );

factory ProjectModel.fromJson(Map<String, dynamic> json) {
  return ProjectModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    imageUrls: (json['imageUrls'] as List)
      .map((img) => img['imageUrl'] as String)
      .toList(),
    imageIds: (json['imageUrls'] as List)
      .map((img) => img['id'] as int)
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


