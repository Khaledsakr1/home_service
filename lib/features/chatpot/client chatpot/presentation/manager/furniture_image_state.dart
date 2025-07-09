part of 'furniture_image_cubit.dart';

abstract class FurnitureImageState extends Equatable {
  const FurnitureImageState();

  @override
  List<Object> get props => [];
}

class FurnitureImageInitial extends FurnitureImageState {}

class FurnitureImageLoading extends FurnitureImageState {}

class FurnitureImageLoaded extends FurnitureImageState {
  final FurnitureImage image;

  const FurnitureImageLoaded(this.image);

  @override
  List<Object> get props => [image];
}

class FurnitureImageError extends FurnitureImageState {
  final String message;

  const FurnitureImageError(this.message);

  @override
  List<Object> get props => [message];
}
