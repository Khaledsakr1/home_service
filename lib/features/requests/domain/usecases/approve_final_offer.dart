import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class ApproveFinalOffer implements UseCase<Request, ApproveFinalOfferParams> {
  final RequestRepository repository;
  ApproveFinalOffer(this.repository);

  @override
  Future<Either<Failure, Request>> call(ApproveFinalOfferParams params) {
    return repository.approveFinalOffer(params.requestId, params.isApprove);
  }
}

class ApproveFinalOfferParams {
  final int requestId;
  final bool isApprove;
  ApproveFinalOfferParams({required this.requestId, required this.isApprove});
}
