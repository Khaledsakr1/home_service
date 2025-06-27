
part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String message;

  const AuthenticationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends AuthenticationState {
  final Map<String, dynamic> userData;

  const LoginSuccess(this.userData);

  @override
  List<Object> get props => [userData];
}

class EmailCheckResult extends AuthenticationState {
  final bool exists;

  const EmailCheckResult(this.exists);

  @override
  List<Object> get props => [exists];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}


