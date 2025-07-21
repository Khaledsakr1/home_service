import 'package:equatable/equatable.dart';

class ClientProject extends Equatable {
  final int id;
  final String name;
  final int serviceId;
  final String serviceName;
  final String apartmentType;
  final String apartmentSize;
  final String preferredStyle;
  final String materialQuality;
  final double minBudget;
  final double maxBudget;
  final String details;
  final String createdDate;
  final List<ProjectImage> projectImages;

  const ClientProject({
    required this.id,
    required this.name,
    required this.serviceId,
    required this.serviceName,
    required this.apartmentType,
    required this.apartmentSize,
    required this.preferredStyle,
    required this.materialQuality,
    required this.minBudget,
    required this.maxBudget,
    required this.details,
    required this.createdDate,
    required this.projectImages,
  });

  @override
  List<Object?> get props => [
    id, name, serviceId, serviceName, apartmentType, apartmentSize, preferredStyle,
    materialQuality, minBudget, maxBudget, details, createdDate, projectImages
  ];
}

class ProjectImage extends Equatable {
  final int id;
  final String imageUrl;

  const ProjectImage({required this.id, required this.imageUrl});

  @override
  List<Object?> get props => [id, imageUrl];
}
