import 'package:home_service/features/services/domain/entities/service.dart';

class ServiceModel extends Service {
  const ServiceModel({
    required int id,
    required String name,
    // required String imageUrl,
  }) : super(
          id: id,
          name: name,
          // imageUrl: imageUrl,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      // imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'imageUrl': imageUrl,
    };
  }
}


