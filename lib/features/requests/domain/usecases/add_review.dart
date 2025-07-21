// 5. Create AddReview Use Case
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/review_entity.dart';
import '../repositories/request_repository.dart';

class AddReview implements UseCase<Review, AddReviewParams> {
  final RequestRepository repository;

  AddReview(this.repository);

  @override
  Future<Either<Failure, Review>> call(AddReviewParams params) {
    return repository.addReview(params.workerId, params.comment, params.rating);
  }
}

class AddReviewParams {
  final int workerId;
  final String comment;
  final int rating;
  
  AddReviewParams({
    required this.workerId,
    required this.comment,
    required this.rating,
  });
}