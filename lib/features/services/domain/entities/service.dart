import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String name;
  // final String imageUrl;

  const Service({
    required this.id,
    required this.name,
    // required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name,];
}


