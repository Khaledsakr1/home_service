// features/worker_search/presentation/manager/worker_search_state.dart
part of 'worker_search_cubit.dart';

abstract class WorkerSearchState extends Equatable {
  const WorkerSearchState();

  @override
  List<Object?> get props => [];
}

class WorkerSearchInitial extends WorkerSearchState {}

class WorkerSearchLoading extends WorkerSearchState {}

class WorkerSearchLoaded extends WorkerSearchState {
  final List<int> workerIds;
  const WorkerSearchLoaded(this.workerIds);
  @override
  List<Object?> get props => [workerIds];
}

class WorkerSearchError extends WorkerSearchState {
  final String message;
  const WorkerSearchError(this.message);
  @override
  List<Object?> get props => [message];
}
