import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/clear_token.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';

class WorkerSettingsDataAndPrivacyDeactivateAcc extends StatelessWidget {
  const WorkerSettingsDataAndPrivacyDeactivateAcc({super.key});

  void _confirmDeactivate(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Deactivate Account"),
        content: const Text(
            "Are you sure you want to deactivate your account? You will be logged out."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text("Deactivate", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      context.read<WorkerSettingsCubit>().deactivateAccount();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkerSettingsCubit, WorkerSettingsState>(
      listener: (context, state) {
        if (state is WorkerSettingsDeactivateSuccess) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Account Deactivated"),
              content: const Text(
                  "Your account has been deactivated. You will be logged out."),
              actions: [
                TextButton(
                  onPressed: () async {
                    await clearTokenOnLogout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginAsWorker.id,
                      (route) => false,
                    );
                  },
                  child: const Text("OK"),
                )
              ],
            ),
          );
        } else if (state is WorkerSettingsError) {
          showErrorOverlayMessage(context, errorMessage: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is WorkerSettingsLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.green,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Deactivate my account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/DeactivateAcc.jpg',
                    height: 160,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Need a break?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "By deactivating your account, both your Service Provider and Customer accounts will be disabled and you will be logged out of the platform.\n\n"
                  "The deactivation process is reversible. You can reactivate your account at any time by simply logging back in. Your data will be exactly as you left it.\n\n"
                  "If you would like to know your personal data, you can take a look at our explanatory text.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 130),
                Center(
                  child: Button(
                    title: isLoading ? "Deactivating..." : "Deactivate Account",
                    textColor: Colors.red,
                    backgroundColor: Colors.white,
                    borderColor: Colors.red,
                    ontap: isLoading ? null : () => _confirmDeactivate(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
