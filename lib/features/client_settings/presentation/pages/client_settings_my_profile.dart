import 'package:flutter/material.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_my_profile_address.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_my_profile_information.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_my_profile_mobile_number.dart';
import 'package:home_service/widgets/Optiontile.dart';

class Settingsmyprofile extends StatelessWidget {
  const Settingsmyprofile({super.key});

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
          'My Profile',
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
                title: 'Profile information',
                subtitle:
                    'Edit your profile picture, name, surname, and email.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsmyprofileInformation()),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Mobile phone number',
                subtitle: 'Modify your mobile phone number',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsmyprofileMobilenumber()),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Address Preferences',
                subtitle: 'Edit your address preference',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsmyprofileAddresses()),
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
