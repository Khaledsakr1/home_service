import 'package:flutter/material.dart';
import 'package:home_service/features/worker_home/presentation/pages/RequestViewDetails.dart';
import 'package:home_service/features/worker_home/presentation/widgets/filter_tabs.dart';
import 'package:home_service/features/worker_home/presentation/widgets/request_card.dart';

class RequestsscreenWorker extends StatefulWidget {
  const RequestsscreenWorker({super.key});

  @override
  State<RequestsscreenWorker> createState() => _RequestsscreenWorkerState();
}

class _RequestsscreenWorkerState extends State<RequestsscreenWorker> {
  String selectedTab = 'Unread';
  final List<String> tabs = ['All', 'Unread', 'Closest', 'Urgent', 'Latest'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Tabs
          FilterTabsWidget(
            selectedTab: selectedTab,
            onTabSelected: (tab) {
              setState(() {
                selectedTab = tab;
              });
            },
            tabs: tabs,
          ),
          // Requests List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                RequestCardWidget(
                  name: 'Mohamed Hassan',
                  service: 'Plumbing Pipe Repair',
                  date: '23 march',
                  isUrgent: true,
                  tags: ['villa', '400', 'Modern', 'high quality'],
                  location: 'Ismailia, el salaam',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Requestviewdetails(
                          title: 'Plumbing Pipe Repair',
                          image: '',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                RequestCardWidget(
                  name: 'Mohamed Hassan',
                  service: 'Plumbing Pipe Repair',
                  date: '23 march',
                  isUrgent: false,
                  tags: ['villa', '400', 'Modern', 'high quality'],
                  location: 'Ismailia, el salaam',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Requestviewdetails(
                          title: 'Plumbing Pipe Repair',
                          image: '',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}