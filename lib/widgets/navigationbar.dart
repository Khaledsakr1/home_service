import 'package:flutter/material.dart';
import 'package:home_service/features/chatpot/client%20chatpot/StartChatBot.dart';
import 'package:home_service/features/client_home/presentation/pages/RequestsScreen.dart';
import 'package:home_service/features/client_home/presentation/pages/StartNewProject.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_screen.dart';
import 'package:home_service/features/services/presentation/pages/main_service_page.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});
  static String id = 'navigationbar';

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainServicePage(),
    Requestsscreen(),
    Startchatbot(),
    Settingsscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // action للزر الدائري الأوسط
          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Startnewproject()),
    );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
                _buildNavItem(
                    icon: Icons.assignment, label: 'Requests', index: 1),
                const SizedBox(width: 40), // مكان زر الفاب
                _buildNavItem(icon: Icons.chat, label: 'ChatBot', index: 2),
                _buildNavItem(icon: Icons.settings, label: 'Setting', index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.green : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 3,
              width: 50,
              color: Colors.green,
            )
        ],
      ),
    );
  }
}