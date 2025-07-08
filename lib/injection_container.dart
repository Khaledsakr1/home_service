import 'package:get_it/get_it.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_cubit.dart';
import 'package:home_service/features/chat/data/datasources/chat_signalr_service.dart';
import 'package:http/http.dart' as http;
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:home_service/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:home_service/features/authentication/domain/usecases/check_email_exists.dart';
import 'package:home_service/features/authentication/domain/usecases/login_user.dart';
import 'package:home_service/features/authentication/domain/usecases/register_customer.dart';
import 'package:home_service/features/authentication/domain/usecases/register_worker.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/client_project/data/datasources/client_project_remote_data_source.dart';
import 'package:home_service/features/client_project/data/repositories/client_project_repository_impl.dart';
import 'package:home_service/features/client_project/domain/repositories/client_project_repository.dart';
import 'package:home_service/features/client_project/domain/usecases/add_project.dart';
import 'package:home_service/features/client_project/domain/usecases/add_project_images.dart';
import 'package:home_service/features/client_project/domain/usecases/delete_project.dart';
import 'package:home_service/features/client_project/domain/usecases/delete_project_image.dart';
import 'package:home_service/features/client_project/domain/usecases/get_project.dart';
import 'package:home_service/features/client_project/domain/usecases/get_projects.dart';
import 'package:home_service/features/client_project/domain/usecases/update_project.dart';
import 'package:home_service/features/client_project/presentation/manager/client_project_cubit.dart';
import 'package:home_service/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:home_service/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio_images.dart';
import 'package:home_service/features/portfolio/domain/usecases/delete_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/delete_portfolio_image.dart';
import 'package:home_service/features/portfolio/domain/usecases/get_portfolios.dart';
import 'package:home_service/features/portfolio/domain/usecases/update_portfolio.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/features/requests/data/datasources/request_remote_data_source.dart';
import 'package:home_service/features/requests/data/datasources/worker_request_remote_data_source.dart';
import 'package:home_service/features/requests/data/repositories/request_repository_impl.dart';
import 'package:home_service/features/requests/data/repositories/worker_request_repository_impl.dart';
import 'package:home_service/features/requests/domain/repositories/request_repository.dart';
import 'package:home_service/features/requests/domain/repositories/worker_request_repository.dart';
import 'package:home_service/features/requests/domain/usecases/accept_request.dart';
import 'package:home_service/features/requests/domain/usecases/add_review.dart';
import 'package:home_service/features/requests/domain/usecases/approve_final_offer.dart';
import 'package:home_service/features/requests/domain/usecases/cancel_request.dart';
import 'package:home_service/features/requests/domain/usecases/complete_request.dart';
import 'package:home_service/features/requests/domain/usecases/get_customer_requests.dart';
import 'package:home_service/features/requests/domain/usecases/get_received_requests.dart';
import 'package:home_service/features/requests/domain/usecases/reject_request.dart';
import 'package:home_service/features/requests/domain/usecases/send_request.dart';
import 'package:home_service/features/requests/presentation/manager/request_cubit.dart';
import 'package:home_service/features/requests/presentation/manager/worker_request_cubit.dart';
import 'package:home_service/features/services/data/datasources/service_remote_data_source.dart';
import 'package:home_service/features/services/data/repositories/service_repository_impl.dart';
import 'package:home_service/features/services/domain/repositories/service_repository.dart';
import 'package:home_service/features/services/domain/usecases/get_services.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/worker_details/data/datasources/worker_remote_data_source.dart';
import 'package:home_service/features/worker_details/data/repositories/worker_repository_impl.dart';
import 'package:home_service/features/worker_details/domain/repositories/worker_repository.dart';
import 'package:home_service/features/worker_details/domain/usecases/get_worker_by_id.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_cubit.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/repositories/worker_settings_repository.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/deactivate_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/delete_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => http.Client());

  // Services
  sl.registerLazySingleton<TokenService>(() => TokenService());

  // ✅ Chat SignalR Service
  sl.registerLazySingleton<ChatSignalRService>(() => ChatSignalRService());

  // Chat Cubit
  sl.registerFactory(() => ChatCubit(chatService: sl()));

  // ===================== AUTH =====================
  sl.registerFactory(() => AuthenticationCubit(
        loginUserUseCase: sl(),
        registerCustomerUseCase: sl(),
        registerWorkerUseCase: sl(),
        checkEmailExistsUseCase: sl(),
      ));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterCustomer(sl()));
  sl.registerLazySingleton(() => RegisterWorker(sl()));
  sl.registerLazySingleton(() => CheckEmailExists(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(client: sl()),
  );

  // ===================== SERVICES =====================
  sl.registerFactory(() => ServicesCubit(getServicesUseCase: sl()));
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(remoteDataSource: sl()),
  );
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
      deletePortfolioImageUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AddPortfolio(sl()));
  sl.registerLazySingleton(() => UpdatePortfolio(sl()));
  sl.registerLazySingleton(() => DeletePortfolio(sl()));
  sl.registerLazySingleton(() => GetPortfolios(sl()));
  sl.registerLazySingleton(() => AddPortfolioImages(sl()));
  sl.registerLazySingleton(() => DeletePortfolioImage(sl()));

  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(client: sl()),
  );

  // ===================== CLIENT PROJECT =====================
  sl.registerLazySingleton<ClientProjectRemoteDataSource>(
    () => ClientProjectRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ClientProjectRepository>(
    () => ClientProjectRepositoryImpl(sl()),
  );
  sl.registerFactory(() => AddProject(sl()));
  sl.registerFactory(() => UpdateProject(sl()));
  sl.registerFactory(() => GetProject(sl()));
  sl.registerFactory(() => GetProjects(sl()));
  sl.registerFactory(() => DeleteProject(sl()));
  sl.registerFactory(() => AddProjectImages(sl()));
  sl.registerFactory(() => DeleteProjectImage(sl()));
  sl.registerFactory(() => ClientProjectCubit(
        addProjectUseCase: sl(),
        updateProjectUseCase: sl(),
        getProjectUseCase: sl(),
        getProjectsUseCase: sl(),
        deleteProjectUseCase: sl(),
        addProjectImagesUseCase: sl(),
        deleteProjectImageUseCase: sl(),
      ));

  // ===================== REQUESTS =====================
  sl.registerFactory(() => RequestCubit(
        sendRequestUseCase: sl(),
        cancelRequestUseCase: sl(),
        getCustomerRequestsUseCase: sl(),
        completeRequestUseCase: sl(),
        addReviewUseCase: sl(),
        approveFinalOfferUseCase: sl(),
      ));
  sl.registerLazySingleton(() => SendRequest(sl()));
  sl.registerLazySingleton(() => CancelRequest(sl()));
  sl.registerLazySingleton(() => GetCustomerRequests(sl()));
  sl.registerLazySingleton(() => CompleteRequest(sl()));
  sl.registerLazySingleton(() => AddReview(sl()));
  sl.registerLazySingleton(() => ApproveFinalOffer(sl()));
  sl.registerLazySingleton<RequestRepository>(
    () => RequestRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RequestRemoteDataSource>(
    () => RequestRemoteDataSourceImpl(client: sl()),
  );

  // ===================== WORKER REQUESTS =====================
  sl.registerLazySingleton<WorkerRequestRemoteDataSource>(
    () => WorkerRequestRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<WorkerRequestRepository>(
    () => WorkerRequestRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetReceivedRequests(sl()));
  sl.registerLazySingleton(() => AcceptRequest(sl()));
  sl.registerLazySingleton(() => RejectRequest(sl()));
  sl.registerFactory(() => WorkerRequestCubit(
        getReceivedRequestsUseCase: sl(),
        acceptRequestUseCase: sl(),
        rejectRequestUseCase: sl(),
      ));

  // ===================== WORKER SETTINGS =====================
  sl.registerFactory(() => WorkerSettingsCubit(
        fetchWorkerProfileUseCase: sl(),
        updateWorkerProfileUseCase: sl(),
        updateProfilePictureUseCase: sl(),
        changePasswordUseCase: sl(),
        deleteAccountUseCase: sl(),
        deactivateAccountUseCase: sl(),
      ));
  sl.registerLazySingleton(() => FetchWorkerProfile(sl()));
  sl.registerLazySingleton(() => UpdateWorkerProfile(sl()));
  sl.registerLazySingleton(() => UpdateWorkerProfileWithImage(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => DeleteAccount(sl()));
  sl.registerLazySingleton(() => DeactivateAccount(sl()));
  sl.registerLazySingleton<WorkerSettingsRepository>(
    () => WorkerSettingsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WorkerSettingsRemoteDataSource>(
    () => WorkerSettingsRemoteDataSourceImpl(),
  );
}
