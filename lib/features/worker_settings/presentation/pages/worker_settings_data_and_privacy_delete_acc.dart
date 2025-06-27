import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/utils/clear_token.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';

class WorkerSettingsDataAndPrivacyDeleteAcc extends StatelessWidget {
  const WorkerSettingsDataAndPrivacyDeleteAcc({super.key});

  void _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
            "Are you sure you want to delete your account? This action is irreversible."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      context.read<WorkerSettingsCubit>().deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkerSettingsCubit, WorkerSettingsState>(
      listener: (context, state) {
        if (state is WorkerSettingsDeleteSuccess) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Account Deleted"),
              content:
                  const Text("Your account has been deleted successfully."),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
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
              'Delete my account',
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
                  child:
                      Image.asset('assets/images/DeleteAcc.jpg', height: 150),
                ),
                const SizedBox(height: 24),
                const Text(
                  "We're sorry to see you go!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Before we continue, we want to share some useful information with you.\n\n"
                  "By deleting your account:\n"
                  "• Your Service Provider and Customer accounts will be permanently deleted from our databases.\n"
                  "• Deletion is irreversible and you will no longer be able to access this data.\n"
                  "• If you decide to use the app again, you'll need to create a new account.\n"
                  "• If you have a non‑refundable balance in your account, it will be deleted and will not be refundable after the account is deleted.\n\n"
                  "If you are considering deleting your account because you no longer provide a service, you can consider deactivating it instead.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Button(
                    title: isLoading ? "Deleting..." : "Delete my account",
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    ontap: isLoading ? null : () => _confirmDelete(context),
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
