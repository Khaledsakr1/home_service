import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';

class WorkerSettingschangepassword extends StatefulWidget {
  const WorkerSettingschangepassword({super.key});

  @override
  State<WorkerSettingschangepassword> createState() => _WorkerSettingschangepasswordState();
}

class _WorkerSettingschangepasswordState extends State<WorkerSettingschangepassword> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatNewPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    repeatNewPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<WorkerSettingsCubit>().changePassword(
            currentPassword: oldPasswordController.text,
            newPassword: newPasswordController.text,
            confirmPassword: repeatNewPasswordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkerSettingsCubit, WorkerSettingsState>(
      listener: (context, state) {
        if (state is WorkerSettingsPasswordChangeSuccess) {
         showCustomOverlayMessage(context, message: 'Success', subMessage: 'Password changed successfully!');
          Navigator.pop(context); // Close the change password screen
        } else if (state is WorkerSettingsError) {
          showErrorOverlayMessage(context, errorMessage: 'Failed', subMessage: 'Falied to change password! Please try again.');
        }
      },
      builder: (context, state) {
        final isLoading = state is WorkerSettingsLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              color: Colors.green,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: const Text(
              'Change password',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Change password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'To update your credentials, please enter your old password and your new password.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Textfield(
                  title: 'Old password',
                  headtextfield: 'Enter your old password',
                  obscuretext: true,
                  controller: oldPasswordController,
                  validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Color(0xFF6C8090),
                  thickness: 2,
                  indent: 40,
                  endIndent: 40,
                  height: 15,
                ),
                const SizedBox(height: 20),
                Textfield(
                  title: 'New password',
                  headtextfield: 'Enter your new password',
                  obscuretext: true,
                  controller: newPasswordController,
                  validator: (v) => (v == null || v.length < 6) ? "At least 6 characters" : null,
                ),
                const SizedBox(height: 20),
                Textfield(
                  title: 'Repeat new password',
                  headtextfield: 'Enter your new password again',
                  obscuretext: true,
                  controller: repeatNewPasswordController,
                  validator: (v) => (v != newPasswordController.text) ? "Passwords do not match" : null,
                ),
                const SizedBox(height: 40),
                Button(
                  title: isLoading ? "Saving..." : "Save",
                  ontap: isLoading ? null : () => _submit(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
