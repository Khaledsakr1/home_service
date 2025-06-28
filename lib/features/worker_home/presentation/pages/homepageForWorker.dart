import 'package:flutter/material.dart';
import 'package:home_service/features/services/presentation/pages/see_all_services_page.dart';
import 'package:home_service/features/worker_home/presentation/pages/ServiceDetailsPage.dart';
import 'package:home_service/widgets/HomeServicelist.dart';
import 'package:home_service/widgets/PopularServicelist.dart';
import 'package:home_service/widgets/RepairandInstallationlist.dart';
import 'package:home_service/widgets/TitleWithSeeAll.dart';

class HomepageForWorker extends StatelessWidget {
  const HomepageForWorker({super.key});
  static String id = 'home page for worker';

  final List<Map<String, String>> popularservicesIMG = const [
    {'title': 'House Cleaning', 'image': 'assets/images/house cleaning.png'},
    {'title': 'Electrical', 'image': 'assets/images/electrical.png'},
    {'title': 'Furniture Moving', 'image': 'assets/images/furniture.png'},
    {'title': 'Water Filter', 'image': 'assets/images/water filter.png'},
    {'title': 'Pest Control', 'image': 'assets/images/pest control.png'},
  ];

  final List<Map<String, String>> homeserviceIMG = const [
    {
      'title': 'Apartment Finishing',
      'image': 'assets/images/Apartment finish.jpg'
    },
    {'title': 'Door Carpenter', 'image': 'assets/images/door carprnter.jpg'},
    {'title': 'Interior Design', 'image': 'assets/images/interior design.jpg'},
  ];

  final List<Map<String, String>> repairserviceIMG = const [
    {
      'title': 'Air conditioning maintenance and installation',
      'image': 'assets/images/Air condition.jpg'
    },
    {
      'title': 'Installing surveillance cameras',
      'image': 'assets/images/installing cameras.jpg'
    },
    {
      'title': 'Plumbing Establishment',
      'image': 'assets/images/Plumbing establishing.png'
    },
  ];

  final List<Map<String, String>> transportationserviceIMG = const [
    {'title': 'Furniture Moving', 'image': 'assets/images/furniture.png'},
    {
      'title': 'Furniture lifting winch',
      'image': 'assets/images/Furniture lifting winch.jpg'
    },
    {
      'title': 'Delivery Services',
      'image': 'assets/images/delivery services.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              'LOGO',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Find the perfect job you need',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Jobs'),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularservicesIMG.length,
              itemBuilder: (context, index) {
                final service = popularservicesIMG[index];
                final title = service['title'];
                final image = service['image'];

                if (title == null || image == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsPage(
                          title: title,
                          image: image,
                        ),
                      ),
                    );
                  },
                  child: PopularServiceList(title, image),
                );
              },
            ),
          ),
          TitleWithSeeAll(
            title: 'Home Jobs',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeeallServicepage(
                    pageTitle: 'Home Jobs',
                    services: homeserviceIMG
                        .map((service) => ServiceItem(
                              imageUrl: service['image'] ?? '',
                              title: service['title'] ?? '',
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeserviceIMG.length,
              itemBuilder: (context, index) {
                final service = homeserviceIMG[index];
                final title = service['title'];
                final image = service['image'];

                if (title == null || image == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsPage(
                          title: title,
                          image: image,
                        ),
                      ),
                    );
                  },
                  child: HomeServicelist(title, image),
                );
              },
            ),
          ),
          TitleWithSeeAll(
            title: 'Repair and Installation',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeeallServicepage(
                    pageTitle: 'Repair and Installation',
                    services: repairserviceIMG
                        .map((service) => ServiceItem(
                              imageUrl: service['image'] ?? '',
                              title: service['title'] ?? '',
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: repairserviceIMG.length,
              itemBuilder: (context, index) {
                final service = repairserviceIMG[index];
                final title = service['title'];
                final image = service['image'];

                if (title == null || image == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsPage(
                          title: title,
                          image: image,
                        ),
                      ),
                    );
                  },
                  child: Repairandinstallationlist(title, image),
                );
              },
            ),
          ),
          TitleWithSeeAll(
            title: 'Transportation Services',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeeallServicepage(
                    pageTitle: 'Transportation Services',
                    services: transportationserviceIMG
                        .map((service) => ServiceItem(
                              imageUrl: service['image'] ?? '',
                              title: service['title'] ?? '',
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: transportationserviceIMG.length,
              itemBuilder: (context, index) {
                final service = transportationserviceIMG[index];
                final title = service['title'];
                final image = service['image'];

                if (title == null || image == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailsPage(
                          title: title,
                          image: image,
                        ),
                      ),
                    );
                  },
                  child: Repairandinstallationlist(title, image),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}