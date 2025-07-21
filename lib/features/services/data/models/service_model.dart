import '../../domain/entities/service.dart';
import 'worker_model.dart';

class ServiceModel extends Service {
  const ServiceModel({
    required int id,
    required String name,
    required String imageUrl,
    required List<WorkerModel> workers,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    workers: workers,
  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    var workersList = <WorkerModel>[];
    if (json['workers'] != null) {
      workersList = (json['workers'] as List)
          .map((w) => WorkerModel.fromJson(w))
          .toList();
    }
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['pictureUrl'],
      workers: workersList,
    );
  }
}
