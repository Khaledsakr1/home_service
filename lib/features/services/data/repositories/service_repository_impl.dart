
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/services/data/datasources/service_remote_data_source.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      final result = await remoteDataSource.getServices();
      return Right(result);
    } catch (e) {
      print('ServiceRepositoryImpl.getServices error: $e');
      return Left(ServerFailure());
    }
  }
}


