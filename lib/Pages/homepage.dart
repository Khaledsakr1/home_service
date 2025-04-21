import 'package:flutter/material.dart';
import 'package:home_service/widgets/HomeServicelist.dart';
import 'package:home_service/widgets/PopularServicelist.dart';
import 'package:home_service/widgets/RepairandInstallationlist.dart';
import 'package:home_service/widgets/TitleWithSeeAll.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  static String id = 'homepage';

  final List<Map<String, String>> popularservicesIMG = const [
    {'title': 'House Cleaning', 'image': 'assets/images/house cleaning.png'},
    {'title': 'Electrical', 'image': 'assets/images/electrical.png'},
    {'title': 'Furniture Moving', 'image': 'assets/images/furniture.png'},
    {'title': 'Water Filter', 'image': 'assets/images/water filter.png'},
    {'title': 'Best Control ', 'image': 'assets/images/pest control.png'},
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
      'title': 'delivery services',
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
            Text(
              'LOGO',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find the perfect service you need',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SectionTitle(title: 'Popular Services'),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularservicesIMG.length,
              itemBuilder: (context, index) {
                return PopularServiceList(
                  popularservicesIMG[index]['title']!,
                  popularservicesIMG[index]['image']!,
                );
              },
            ),
          ),
          TitleWithSeeAll(title: 'Home Services'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeserviceIMG.length,
              itemBuilder: (context, index) {
                return HomeServicelist(
                  homeserviceIMG[index]['title']!,
                  homeserviceIMG[index]['image']!,
                );
              },
            ),
          ),
          TitleWithSeeAll(title: 'Repair and Installation'),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: repairserviceIMG.length,
              itemBuilder: (context, index) {
                return Repairandinstallationlist(
                  repairserviceIMG[index]['title']!,
                  repairserviceIMG[index]['image']!,
                );
              },
            ),
          ),
          TitleWithSeeAll(title: 'Transportation Services'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: transportationserviceIMG.length,
              itemBuilder: (context, index) {
                return Repairandinstallationlist(
                  transportationserviceIMG[index]['title']!,
                  transportationserviceIMG[index]['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
