import '../../domain/entities/client_project.dart';

class ClientProjectModel extends ClientProject {
  const ClientProjectModel({
    required int id,
    required String name,
    required int serviceId,
    required String serviceName,
    required String apartmentType,
    required String apartmentSize,
    required String preferredStyle,
    required String materialQuality,
    required double minBudget,
    required double maxBudget,
    required String details,
    required String createdDate,
    required List<ProjectImage> projectImages,
  }) : super(
    id: id,
    name: name,
    serviceId: serviceId,
    serviceName: serviceName,
    apartmentType: apartmentType,
    apartmentSize: apartmentSize,
    preferredStyle: preferredStyle,
    materialQuality: materialQuality,
    minBudget: minBudget,
    maxBudget: maxBudget,
    details: details,
    createdDate: createdDate,
    projectImages: projectImages,
  );

  factory ClientProjectModel.fromJson(Map<String, dynamic> json) {
    return ClientProjectModel(
      id: json['id']??'',
      name: json['name']??'',
      serviceId: json['serviceId']??'',
      serviceName: json['serviceName']??'',
      apartmentType: json['apartmentType']??'',
      apartmentSize: json['apartmentSize']??'',
      preferredStyle: json['preferredStyle']??'',
      materialQuality: json['materialQuality']??'',
      minBudget: (json['minBudget'] ?? 0).toDouble(),
      maxBudget: (json['maxBudget'] ?? 0).toDouble(),
      details: json['details'] ?? '',
      createdDate: json['createdDate'] ?? '',
      projectImages: (json['projectImages'] as List? ?? [])
          .map((img) => ProjectImage(
              id: img['id'], imageUrl: img['imageUrl'] ?? ""))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'apartmentType': apartmentType,
      'apartmentSize': apartmentSize,
      'preferredStyle': preferredStyle,
      'materialQuality': materialQuality,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'details': details,
      'createdDate': createdDate,
      'projectImages': projectImages.map((e) => {'id': e.id, 'imageUrl': e.imageUrl}).toList(),
    };
  }
}
