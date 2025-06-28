import 'package:flutter/material.dart';
import 'package:home_service/widgets/Button.dart';

class Viewdetails extends StatelessWidget {
  final String title;
  final String image;

  Viewdetails({Key? key, required this.title, required this.image})
      : super(key: key);

  // قائمة الصور (مؤقتًا صور من assets)
  final List<String> images = [
    'assets/images/1..png',
    'assets/images/2..png',
    'assets/images/3..png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.green,
                          child: const Icon(Icons.person, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Khaled Sakr',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Plumbing Pipe Repair',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Request Info
            _infoCard(children: [
              _infoRow(Icons.calendar_today, 'Request made March 17, 2025.'),
              _infoRow(Icons.location_on,
                  '130, EL Tahrir Street, dokki, Giza, Egypt'),
              _infoRow(Icons.phone, 'You can contact this customer.'),
            ]),
            const SizedBox(height: 16),

            // Job Info
            _infoCard(children: [
              _buildDetailRow('Apartment type', 'Villa'),
              const SizedBox(height: 16),
              _buildDetailRow('Apartment size (meter)', '400'),
              const SizedBox(height: 16),
              _buildDetailRow('Preferred style', 'Modern'),
              const SizedBox(height: 16),
              _buildDetailRow('Material quality', 'high quality'),
              const SizedBox(height: 16),
              _buildDetailRow('Budget Range', '0 EGP - 100,000 EGP'),
              const SizedBox(height: 16),
              const Text(
                'What are the details of your job application?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                'text jjqq3n,bjKhjbktkenhnro\nbjkjemjhyhjt',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ]),
            const SizedBox(height: 16),

            // Photos (معدل)
            _infoCard(children: [
              const Text('Photos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SizedBox(
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length + 1, // الصور + زر الإضافة
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index < images.length) {
                      return Container(
                        width: 70,
                        height: 70,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      );
                    } else {
                      // زر الإضافة
                      return GestureDetector(
                        onTap: () {
                          // افتح المعرض هنا
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: Colors.green),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
            const SizedBox(height: 16),

            // Client Info
            _infoCard(children: [
              const Text('About the client',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _infoRow(Icons.calendar_today, 'Registered 3 Years ago'),
              _infoRow(Icons.work, '1 job has expired'),
            ]),
            const SizedBox(height: 24),

            // Buttons
            Column(
              children: [
                Button(
                  title: 'Accept',
                  icon: Icons.check,
                  ontap: () {},
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.delete_outline, color: Colors.grey),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hourglass_empty,
                                color: Colors.orange, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Pending......',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        title: 'Cancel',
                        icon: Icons.cancel,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        borderColor: Colors.red,
                        ontap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Button(
                        title: 'Finish',
                        icon: Icons.assignment_turned_in,
                        ontap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]))),
      ],
    );
  }
}