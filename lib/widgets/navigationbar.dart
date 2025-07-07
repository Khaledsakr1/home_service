import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/chatpot/client%20chatpot/StartChatBot.dart';
import 'package:home_service/features/client_home/presentation/pages/RequestsScreen.dart';
import 'package:home_service/features/client_project/presentation/pages/project_list_page.dart';
import 'package:home_service/features/services/presentation/pages/main_service_page.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_screen.dart';
import 'package:home_service/features/requests/presentation/manager/request_cubit.dart';
import 'package:home_service/features/requests/presentation/manager/request_state.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});
  static String id = 'navigationbar';

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MainServicePage(),
    const Requestsscreen(),
    const Startchatbot(),
    const WorkerSettingsscreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch requests when navigation bar initializes to get the count
    context.read<RequestCubit>().fetchCustomerRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // action للزر الدائري الأوسط
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProjectsListPage()),
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
            child: BlocBuilder<RequestCubit, RequestState>(
              builder: (context, state) {
                // Count approve status requests
                int approveCount = 0;
                if (state is RequestsLoaded) {
                  approveCount = state.requests.where((r) => r.statusCode == 5).length;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
                    _buildNavItem(
                      icon: Icons.assignment, 
                      label: 'Requests', 
                      index: 1,
                      badgeCount: approveCount,
                    ),
                    const SizedBox(width: 40), // مكان زر الفاب
                    _buildNavItem(icon: Icons.chat, label: 'ChatBot', index: 2),
                    _buildNavItem(icon: Icons.settings, label: 'Setting', index: 3),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    int badgeCount = 0,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
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
          // Badge for notification count
          if (badgeCount > 0)
            Positioned(
              right: -8,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}