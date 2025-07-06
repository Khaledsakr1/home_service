part of 'worker_request_cubit.dart';

abstract class WorkerRequestState extends Equatable {
  const WorkerRequestState();
  @override
  List<Object?> get props => [];
}

class WorkerRequestInitial extends WorkerRequestState {}
class WorkerRequestLoading extends WorkerRequestState {}
class WorkerRequestsLoaded extends WorkerRequestState {
  final List<Request> requests;
  const WorkerRequestsLoaded(this.requests);
  @override
  List<Object?> get props => [requests];
}
class WorkerRequestAccepted extends WorkerRequestState {
  final Request request;
  const WorkerRequestAccepted(this.request);
  @override
  List<Object?> get props => [request];
}
class WorkerRequestRejected extends WorkerRequestState {
  final Request request;
  const WorkerRequestRejected(this.request);
  @override
  List<Object?> get props => [request];
}
class WorkerRequestError extends WorkerRequestState {
  final String message;
  const WorkerRequestError(this.message);
  @override
  List<Object?> get props => [message];
}
