//1st SLIDER
/*
import 'package:flutter/material.dart';
import 'package:home_service/Pages/common%20worker%20and%20client%20start%20pages/ClientAndWorkerStart.dart';
import 'package:home_service/widgets/button.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> StartpageData = [
    {
      "image": "assets/images/cleaning service-bro.png",
      "title": "Welcome to Our App!",
      "subtitle": "We provide the best home and personal services for you."
    },
    {
      "image": "assets/images/cleaning service-amico (1).png",
      "title": "Our Services",
      "subtitle":
          "We offer a wide range of services including cleaning, maintenance, and installations."
    },
    {
      "image": "assets/images/Product quality-bro.png",
      "title": "Let’s get Start",
      "subtitle":
          "Connecting you with skilled professionals for all your home and personal needs."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: StartpageData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      StartpageData[index]["image"]!,
                      height: 300,
                    ),

                    const SizedBox(height: 40),

                    Text(
                      StartpageData[index]["title"]!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        StartpageData[index]["subtitle"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 70),

                    // Show the button only on the last page
                    if (index == StartpageData.length - 1)
                      Button(
                        ontap: () {
                          Navigator.pushNamed(context, ClientandWorkerstart.id);
                        },
                        title: 'Let\'s Start....',
                      ),
                  ],
                );
              },
            ),
          ),

          // Dots Indicator at bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              StartpageData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
*/
//2nd SLIDER
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:home_service/common/pages/client_and_worker_start_page.dart';
import 'package:home_service/widgets/button.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Call this function when the onboarding is done
Future<void> setOnboardingSeen() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_seen', true);
}



class Startpage extends StatelessWidget {
  Startpage({super.key});

  final data = [
    ItemData(
      title: "Welcome to Our App!",
      subtitle: "We provide the best home and personal services for you.",
      image: const AssetImage("assets/images/cleaning service-bro.png"),
      backgroundColor: Colors.white,
      titleColor: const Color.fromARGB(255, 5, 73, 0),
      subtitleColor: Colors.black54,
    ),
    ItemData(
      title: "Our Services",
      subtitle:
          "We offer a wide range of services including cleaning, maintenance, and installations.",
      image: const AssetImage("assets/images/cleaning service-amico (1).png"),
      backgroundColor: const Color.fromARGB(255, 5, 73, 0),
      titleColor: Colors.white,
      subtitleColor: Colors.white70,
    ),
    ItemData(
      title: "Let’s Get Started",
      subtitle:
          "Connecting you with skilled professionals for all your home and personal needs.",
      image: const AssetImage("assets/images/Product quality-bro.png"),
      backgroundColor: Colors.white,
      titleColor: const Color.fromARGB(255, 5, 73, 0),
      subtitleColor: Colors.black54,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        radius: 40,
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return ItemWidget(
            data: data[index],
            isLastPage: index == data.length - 1,
          );
        },
      ),
    );
  }
}

class ItemData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  ItemData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
  });
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({required this.data, required this.isLastPage, super.key});

  final ItemData data;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Flexible(flex: 20, child: Image(image: data.image)),
              const Spacer(flex: 1),
              Text(
                data.title,
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              Text(
                data.subtitle,
                style: TextStyle(color: data.subtitleColor, fontSize: 20),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 10),
              if (isLastPage)
                Button(
  title: 'Let\'s Start....',
  ontap: () async {
    await setOnboardingSeen();  // <-- Add this
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ClientandWorkerstart(),
      ),
    );
  },
),

            ],
          ),
        ),
      ],
    );
  }
}
