import 'package:flutter/material.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_dataAndprivacy_deactivateAcc.dart';
import 'package:home_service/features/client_settings/presentation/pages/clent_settings_dataAndprivacy_deleteAcc.dart';
import 'package:home_service/widgets/Optiontile.dart';

class Settingsdataandprivacy extends StatelessWidget {
  const Settingsdataandprivacy({super.key});

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
          'Data and privacy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              OptionTile(
                title: 'Deactivate my account',
                subtitle:
                    'Temporarily deactivate your profile without losing your data. You can reactivate at any time.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsDataAndPrivacyDeactivateAcc()),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Delete my account',
                subtitle: 'Permanently delete all your data.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsDataAndPrivacyDeleteAcc()),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
