import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/domain/usecases/get_services.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final GetServices getServicesUseCase;

  ServicesCubit({required this.getServicesUseCase}) : super(ServicesInitial());

  Future<void> fetchServices() async {
    emit(ServicesLoading());
    final failureOrServices = await getServicesUseCase(NoParams());
    failureOrServices.fold(
      (failure) => emit(ServicesError(_mapFailureToMessage(failure))),
      (services) => emit(ServicesLoaded(services)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network Failure';
      default:
        return 'Unexpected Error';
    }
  }
}


