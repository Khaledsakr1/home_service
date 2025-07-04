import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/authentication/presentation/pages/address_page.dart';
import 'package:home_service/features/authentication/presentation/pages/address_worker_page.dart';
import 'package:home_service/features/authentication/presentation/pages/check_worker_already_login.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';
import 'package:home_service/features/authentication/presentation/pages/login_page.dart';
import 'package:home_service/features/authentication/presentation/pages/phone_number_page.dart';
import 'package:home_service/features/authentication/presentation/pages/phone_number_worker.dart';
import 'package:home_service/features/authentication/presentation/pages/register_as_worker_page.dart';
import 'package:home_service/features/authentication/presentation/pages/register_page.dart';
import 'package:home_service/features/authentication/presentation/pages/sign_up_client_name_page.dart';
import 'package:home_service/features/authentication/presentation/pages/sign_up_worker_name_page.dart';
import 'package:home_service/features/client_home/presentation/pages/SuceesScreen.dart';
import 'package:home_service/common/pages/client_and_worker_start_page.dart';
import 'package:home_service/common/pages/start_page.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_details_page.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_portfolio_list_page.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_portfolio_page.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/worker_home/presentation/pages/SuceesScreenAsWorker.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/widgets/navigationbar.dart';
import 'package:home_service/widgets/navigationbarWorker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

    // 2. Restore the token into TokenService singleton
  await restoreTokenOnAppStart();

  runApp(const Homeservice());
}

Future<void> restoreTokenOnAppStart() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  // Save to singleton for runtime access
  di.sl<TokenService>().token = token;
}

class Homeservice extends StatelessWidget {
  const Homeservice({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => di.sl<AuthenticationCubit>(),
        ),
        BlocProvider<ServicesCubit>(
          create: (context) => di.sl<ServicesCubit>(),
        ),
        BlocProvider<PortfolioCubit>(
          create: (context) => di.sl<PortfolioCubit>(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          LoginAsWorker.id: (context) => const LoginAsWorker(),
          RegisterAsWorker.id: (context) => const RegisterAsWorker(),
          ClientandWorkerstart.id: (context) => const ClientandWorkerstart(),
          SuccessScreen.id: (context) => const SuccessScreen(),
          SuceesscreenasWorker.id: (context) => const SuceesscreenasWorker(),
          AddressPage.id: (context) => const AddressPage(),
          PhoneNumberPage.id: (context) => const PhoneNumberPage(),
          SignUpClientPage.id: (context) => const SignUpClientPage(),
          SignUpWorkerPage.id: (context) => const SignUpWorkerPage(),
          WorkerPhoneNumberPage.id: (context) => const WorkerPhoneNumberPage(),
          AddressWorkerPage.id: (context) => const AddressWorkerPage(),
          WorkerDetailsPage.id: (context) => const WorkerDetailsPage(),
          PortfolioPage.id: (context) => const PortfolioPage(),
          PortfolioListPage.id: (context) => const PortfolioListPage(),
          Navigationbar.id: (context) => const Navigationbar(),
          NavigationbarWorker.id: (context) => const NavigationbarWorker(),
          WorkerAlreadLogin.id: (context) => const WorkerAlreadLogin(),
        },
        debugShowCheckedModeBanner: false,
        home: Startpage(),
      ),
    );
  }
}


