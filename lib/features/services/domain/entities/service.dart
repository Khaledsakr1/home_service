import 'package:equatable/equatable.dart';
import 'worker.dart';

class Service extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<Worker> workers;

  const Service({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.workers,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, workers];
}
