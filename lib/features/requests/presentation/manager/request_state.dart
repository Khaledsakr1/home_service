import 'package:equatable/equatable.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';

abstract class RequestState extends Equatable {
  const RequestState();
  @override
  List<Object?> get props => [];
}

class RequestInitial extends RequestState {}
class RequestLoading extends RequestState {}

class RequestSent extends RequestState {
  final Request request;
  const RequestSent(this.request);
  @override
  List<Object?> get props => [request];
}

class RequestCancelled extends RequestState {
  final Request request;
  const RequestCancelled(this.request);
  @override
  List<Object?> get props => [request];
}

class RequestsLoaded extends RequestState { // <-- ADD THIS
  final List<Request> requests;
  const RequestsLoaded(this.requests);
  @override
  List<Object?> get props => [requests];
}

class RequestError extends RequestState {
  final String message;
  const RequestError(this.message);
  @override
  List<Object?> get props => [message];
}
