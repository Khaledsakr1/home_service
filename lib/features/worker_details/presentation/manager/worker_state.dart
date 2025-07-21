import 'package:equatable/equatable.dart';

import '../../domain/entities/worker.dart';

abstract class WorkerState extends Equatable {
  const WorkerState();

  @override
  List<Object?> get props => [];
}

class WorkerInitial extends WorkerState {}
class WorkerLoading extends WorkerState {}
class WorkerLoaded extends WorkerState {
  final Worker worker;
  const WorkerLoaded(this.worker);
  @override
  List<Object?> get props => [worker];
}
class WorkerError extends WorkerState {
  final String message;
  const WorkerError(this.message);
  @override
  List<Object?> get props => [message];
}
