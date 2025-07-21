import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/request.dart';
import '../../domain/usecases/get_received_requests.dart';
import '../../domain/usecases/accept_request.dart';
import '../../domain/usecases/reject_request.dart';

part 'worker_request_state.dart';

class WorkerRequestCubit extends Cubit<WorkerRequestState> {
  final GetReceivedRequests getReceivedRequestsUseCase;
  final AcceptRequest acceptRequestUseCase;
  final RejectRequest rejectRequestUseCase;

  WorkerRequestCubit({
    required this.getReceivedRequestsUseCase,
    required this.acceptRequestUseCase,
    required this.rejectRequestUseCase,
  }) : super(WorkerRequestInitial());

  Future<void> fetchReceivedRequests({int? status}) async {
    emit(WorkerRequestLoading());
    final result = await getReceivedRequestsUseCase(status);
    result.fold(
      (failure) => emit(WorkerRequestError(failure.message ?? "Failed to load requests")),
      (requests) => emit(WorkerRequestsLoaded(requests)),
    );
  }

  Future<void> acceptRequest(int requestId, double price) async {
    emit(WorkerRequestLoading());
    final result = await acceptRequestUseCase(AcceptRequestParams(requestId: requestId, price: price));
    result.fold(
      (failure) => emit(WorkerRequestError(failure.message ?? "Failed to accept request")),
      (request) => emit(WorkerRequestAccepted(request)),
    );
  }

  Future<void> rejectRequest(int requestId) async {
    emit(WorkerRequestLoading());
    final result = await rejectRequestUseCase(requestId);
    result.fold(
      (failure) => emit(WorkerRequestError(failure.message ?? "Failed to reject request")),
      (request) => emit(WorkerRequestRejected(request)),
    );
  }
}