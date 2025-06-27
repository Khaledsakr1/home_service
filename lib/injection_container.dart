import 'package:get_it/get_it.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:home_service/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:home_service/features/authentication/domain/usecases/check_email_exists.dart';
import 'package:home_service/features/authentication/domain/usecases/login_user.dart';
import 'package:home_service/features/authentication/domain/usecases/register_customer.dart';
import 'package:home_service/features/authentication/domain/usecases/register_worker.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:home_service/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio_images.dart';
import 'package:home_service/features/portfolio/domain/usecases/delete_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/get_portfolios.dart';
import 'package:home_service/features/portfolio/domain/usecases/update_portfolio.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/features/services/data/datasources/service_remote_data_source.dart';
import 'package:home_service/features/services/data/repositories/service_repository_impl.dart';
import 'package:home_service/features/services/domain/repositories/service_repository.dart';
import 'package:home_service/features/services/domain/usecases/get_services.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/repositories/worker_settings_repository.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Authentication
  sl.registerFactory(
    () => AuthenticationCubit(
      loginUserUseCase : sl(),
      registerCustomerUseCase: sl(),
      registerWorkerUseCase: sl(),
      checkEmailExistsUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterCustomer(sl()));
  sl.registerLazySingleton(() => RegisterWorker(sl()));
  sl.registerLazySingleton(() => CheckEmailExists(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(client: sl()),
  );

  // Features - Services
  sl.registerFactory(
    () => ServicesCubit(
      getServicesUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetServices(sl()));

  // Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSourceImpl(client: sl()),
  );

  // Features - Portfolio
sl.registerFactory(
  () => PortfolioCubit(
    addPortfolioUseCase: sl(),
    updatePortfolioUseCase: sl(),
    addPortfolioImagesUseCase: sl(),
    getPortfoliosUseCase: sl(),
    deletePortfolioUseCase: sl(),
  ),
);


  // Use cases
  sl.registerLazySingleton(() => AddPortfolio(sl()));
  sl.registerLazySingleton(() => UpdatePortfolio(sl()));
  sl.registerLazySingleton(() => DeletePortfolio(sl()));
  sl.registerLazySingleton(() => GetPortfolios(sl()));
  sl.registerLazySingleton(() => AddPortfolioImages(sl()));

  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(client: sl()),
  );



  // Features - Worker Settings
  sl.registerFactory(
    () => WorkerSettingsCubit(
      fetchWorkerProfileUseCase: sl(),
      updateWorkerProfileUseCase: sl(),
      updateProfilePictureUseCase: sl()
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => FetchWorkerProfile(sl()));
  sl.registerLazySingleton(() => UpdateWorkerProfile(sl()));
  sl.registerLazySingleton(() => UpdateWorkerProfileWithImage(sl()));

  // Repository
  sl.registerLazySingleton<WorkerSettingsRepository>(
    () => WorkerSettingsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WorkerSettingsRemoteDataSource>(
    () => WorkerSettingsRemoteDataSourceImpl(),
  );



// Register singleton
sl.registerLazySingleton<TokenService>(() => TokenService());

  // External
  sl.registerLazySingleton(() => http.Client());
}


