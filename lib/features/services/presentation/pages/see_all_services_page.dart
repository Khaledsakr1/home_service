// import 'package:flutter/material.dart';
// import 'package:home_service/features/services/domain/entities/service.dart';

// class SeeallServicepage extends StatelessWidget {
//   final String pageTitle;
//   final List<Service> services;
//   static String id = 'See all service page';
//   const SeeallServicepage({
//     Key? key,
//     required this.pageTitle,
//     required this.services,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       leading: IconButton(
//           color: Colors.green,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(pageTitle,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 3 / 4,
//           ),
//           itemCount: services.length,
//           itemBuilder: (context, index) {
//             final service = services[index];
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Image.network(
//                   //   service.imageUrl,
//                   //   fit: BoxFit.cover,
//                   // ),
//                   Container(
//                     alignment: Alignment.bottomCenter,
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child: Text(
//                       service.name,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SeeallServicepage extends StatelessWidget {
  final String pageTitle;
  final List<ServiceItem> services;
  static String id = 'See all service page';
  const SeeallServicepage({
    Key? key,
    required this.pageTitle,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(pageTitle,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    service.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      service.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ServiceItem {
  final String imageUrl;
  final String title;

  ServiceItem({required this.imageUrl, required this.title});
}

