import 'package:flutter/material.dart';
import 'package:home_service/Pages/ClientAndProStart.dart';
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
                          Navigator.pushNamed(context, Clientandprostart.id);
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
