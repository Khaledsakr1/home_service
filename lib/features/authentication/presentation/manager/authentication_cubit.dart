import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/domain/usecases/check_email_exists.dart';
import 'package:home_service/features/authentication/domain/usecases/login_user.dart';
import 'package:home_service/features/authentication/domain/usecases/register_customer.dart';
import 'package:home_service/features/authentication/domain/usecases/register_worker.dart';
import 'package:home_service/injection_container.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final RegisterCustomer registerCustomerUseCase;
  final CheckEmailExists checkEmailExistsUseCase;
  final LoginUser loginUserUseCase;
  final RegisterWorker registerWorkerUseCase;

  AuthenticationCubit({
    required this.registerCustomerUseCase,
    required this.checkEmailExistsUseCase,
    required this.loginUserUseCase,
    required this.registerWorkerUseCase,
  }) : super(AuthenticationInitial());

Future<void> registerCustomer(Customer customer) async {
  emit(AuthenticationLoading());
  final failureOrSuccess = await registerCustomerUseCase(customer);
  failureOrSuccess.fold(
    (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
    (token) async {
      // SAVE TOKEN just like login
     await di.sl<TokenService>().saveToken(token);

      emit(AuthenticationSuccess(token));
    },
  );
}


  Future<void> checkEmail(String email) async {
    emit(AuthenticationLoading());
    final failureOrExists = await checkEmailExistsUseCase(email);
    failureOrExists.fold(
      (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
      (exists) => emit(EmailCheckResult(exists)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(AuthenticationLoading());
    final failureOrUser =
        await loginUserUseCase(LoginParams(email: email, password: password));
    failureOrUser.fold(
        (failure) => emit(AuthenticationError(_mapFailureToMessage(failure))),
        (userData) async{
       final token = userData['token'];
      // 2. Save it to shared preferences
      await di.sl<TokenService>().saveToken(token);


      emit(LoginSuccess(userData));
    });
  }

  Future<void> registerWorker(Worker worker, String? profilePicturePath) async {
    emit(AuthenticationLoading());
    final failureOrSuccess = await registerWorkerUseCase(RegisterWorkerParams(
        worker: worker, profilePicturePath: profilePicturePath));
    failureOrSuccess.fold(
      (failure) {
        print('AuthenticationCubit registerWorker failure: $failure');
        emit(AuthenticationError(_mapFailureToMessage(failure)));
      },
(token) async {
  print('AuthenticationCubit registerWorker success token: $token');
  if (token == null || token.isEmpty) {
    print('AuthenticationCubit registerWorker invalid token');
    emit(AuthenticationError('Invalid token received'));
  } else {
    // SAVE TOKEN exactly like login
  await di.sl<TokenService>().saveToken(token);

    emit(AuthenticationSuccess(token));
  }
},

    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        // Check if the ServerFailure has a specific message
        if (failure is ServerFailure && failure.message != null) {
          return failure.message!;
        }
        return 'Server Failure';
      case CacheFailure:
        if (failure is CacheFailure && failure.message != null) {
          return failure.message!;
        }
        return 'Cache Failure';
      case NetworkFailure:
        if (failure is NetworkFailure && failure.message != null) {
          return failure.message!;
        }
        return 'Network Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
