import 'package:flutter/material.dart';
import 'package:home_service/Pages/SettingsMyProfile.dart';
import 'package:home_service/Pages/StartNewProject.dart';
import 'package:home_service/widgets/Optiontile.dart';

class Settingsscreen extends StatelessWidget {
  const Settingsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Image.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Khaled Sakr',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          OptionTile(
            leadingIcon: Icons.person,
            title: 'My Profile',
            subtitle:
                'Edit your profile picture, name, email, phone number and Location',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settingsmyprofile()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.lock_reset,
            title: 'Change Password',
            subtitle: 'Update and manage your password.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Startnewproject()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.notifications,
            title: 'Notification',
            subtitle:
                'Choose notification preferences and how you want to be contacted.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Startnewproject()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.privacy_tip,
            title: 'Data and Privacy',
            subtitle: 'Protect and delete your account.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Startnewproject()),
              );
            },
          ),
        ],
      ),
    );
  }
}
