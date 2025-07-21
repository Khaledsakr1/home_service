import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class GetCustomerRequests implements UseCase<List<Request>, int?> {
  final RequestRepository repository;

  GetCustomerRequests(this.repository);

  @override
  Future<Either<Failure, List<Request>>> call(int? status) {
    return repository.getCustomerRequests(status: status);
  }
}

