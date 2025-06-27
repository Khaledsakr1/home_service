import 'package:flutter/material.dart';
import 'package:home_service/widgets/button.dart';

class WorkerSettingsDataAndPrivacyDeactivateAcc extends StatelessWidget {
  const WorkerSettingsDataAndPrivacyDeactivateAcc({super.key});

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
          'Deactivate my account',
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
                image: AssetImage(
                    'assets/images/DeactivateAcc.jpg'),
                height: 160,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Need a break?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "By deactivating your account, both your Service Provider and Customer accounts will be disabled and you will be logged out of the platform.\n\n"
              "The deactivation process is reversible. You can reactivate your account at any time by simply logging back in. Your data will be exactly as you left it.\n\n"
              "If you would like to know your personal data, you can take a look at our explanatory text.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 130),
            Center(
              child: Button(
                title: "Deactivate Account",
                textColor: Colors.red,
                backgroundColor: Colors.white,
                borderColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
