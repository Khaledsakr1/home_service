import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/client_settings/presentation/pages/client_settings_my_profile_address_edit.dart';

class SettingsmyprofileAddresses extends StatelessWidget {
  const SettingsmyprofileAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      {
        'street': '15 El Teseen St',
        'subStreet': '90 St',
        'area': 'Nasr City',
        'city': 'Cairo',
      },
      {
        'street': '15 El Teseen St',
        'subStreet': '90 St',
        'area': 'Nasr City',
        'city': 'Cairo',
      },
      {
        'street': '15 El Teseen St',
        'subStreet': '90 St',
        'area': 'Nasr City',
        'city': 'Cairo',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Addresses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final item = addresses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.apartment,
                        size: 20, color: Colors.black87),
                    const SizedBox(width: 8),
                    Text(
                      item['street']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text(
                    item['subStreet']!,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 20, color: Colors.black87),
                    const SizedBox(width: 8),
                    Text(
                      item['area']!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_city,
                        size: 20, color: Colors.black87),
                    const SizedBox(width: 8),
                    Text(
                      item['city']!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingsmyprofileAddressedit()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
