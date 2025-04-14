import 'package:flutter/material.dart';
import 'package:home_service/Pages/NotificationsScreen.dart';
import 'package:home_service/Pages/RequestsScreen.dart';
import 'package:home_service/Pages/SettingsScreen.dart';
import 'package:home_service/Pages/homepage.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});
  static String id = 'navigationbar';
  @override
  State<Navigationbar> createState() => _NavigationbarState();

}

class _NavigationbarState extends State<Navigationbar> {
  int _currentIndex = 0;

  // هنا تكتب الصفحات اللي حابب تتنقل بينها
  final List<Widget> _pages = [
    Homepage(),
    Requestsscreen(),
    Notificationsscreen(),
    Settingsscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],  // يعرض الصفحة بناءً على الاختيار
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // التحديد الحالي
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // يغير الصفحة لما تضغط على أيقونة
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
