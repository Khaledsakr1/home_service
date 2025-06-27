import 'package:flutter/material.dart';
import 'package:home_service/widgets/button.dart';

class SettingsDataAndPrivacyDeleteAcc extends StatelessWidget {
  const SettingsDataAndPrivacyDeleteAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image:
                    AssetImage('assets/images/DeleteAcc.jpg'),
                height: 150,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "We're sorry to see you go!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Before we continue, we want to share some useful information with you.\n\n"
              "By deleting your account:\n"
              "• Your Service Provider and Customer accounts will be permanently deleted from our databases.\n"
              "• Deletion is irreversible and you will no longer be able to access this data.\n"
              "• If you decide to use the app again, you'll need to create a new account.\n"
              "• If you have a non‑refundable balance in your account, it will be deleted and will not be refundable after the account is deleted.\n\n"
              "If you are considering deleting your account because you no longer provide a service, you can consider deactivating it instead.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 30),
            Center(
              child: Button(
                title: "Delete my account",
                textColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
