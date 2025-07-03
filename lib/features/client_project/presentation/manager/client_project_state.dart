part of 'client_project_cubit.dart';

abstract class ClientProjectState extends Equatable {
  const ClientProjectState();
  @override
  List<Object?> get props => [];
}

class ClientProjectInitial extends ClientProjectState {}
class ClientProjectLoading extends ClientProjectState {}

class ClientProjectsLoaded extends ClientProjectState {
  final List<ClientProject> projects;
  const ClientProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

class ClientProjectLoaded extends ClientProjectState {
  final ClientProject project;
  const ClientProjectLoaded(this.project);

  @override
  List<Object?> get props => [project];
}

class ClientProjectActionSuccess extends ClientProjectState {
  final String message;
  const ClientProjectActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ClientProjectError extends ClientProjectState {
  final String message;
  const ClientProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
