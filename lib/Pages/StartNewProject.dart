import 'package:flutter/material.dart';
import 'package:home_service/widgets/BudgetSlider.dart';
import 'package:home_service/widgets/DetailsInput.dart';
import 'package:home_service/widgets/ImagePicker.dart';
import 'package:home_service/widgets/Optiontile.dart';
import 'package:home_service/widgets/Optiontile1.dart';
import 'package:home_service/widgets/Optiontile2.dart';
import 'package:home_service/widgets/Optiontile3.dart';
import 'package:home_service/widgets/TextField2.dart';
import 'package:home_service/widgets/button.dart';

class Startnewproject extends StatefulWidget {
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<Startnewproject> {
  double _budgetValue = 100000;
  bool _isServiceVisible = false;
  bool _isApartmentVisible = false;
  bool _isPreferredvisible = false;
  bool _isMaterialQualityvisible = false;
  bool _isLocationvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Start a new project',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset("assets/images/Attached files.png", height: 200),
            const SizedBox(height: 16),
            Textfield2(hint: 'Project name'),
            const SizedBox(height: 10),

            // هنا نقوم بتعديل الـ OptionTile
            OptionTile(
              title: 'Type of service',
              onTap: () {
                setState(() {
                  _isServiceVisible =
                      !_isServiceVisible; // عكس الحالة عند الضغط
                });
              },
            ),

            // الويدجت الذي سيظهر عند الضغط على "Type of service"
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isServiceVisible
                  ? Optiontile1(
                      title: 'Type of service',
                      options: [
                        'Apartment finishing',
                        'Cleaning',
                        'Plumber',
                        'Electrical',
                        'Furniture moving',
                        'Air conditioning maintenance',
                        'Finishing in installments'
                      ],
                      onSelected: (value) {
                        print("Selected: $value");
                      },
                    )
                  : SizedBox.shrink(), // إخفاء الويدجت عند عدم تفعيله
            ),

            OptionTile(
                title: 'Apartment type & size',
                onTap: () {
                  setState(() {
                    _isApartmentVisible =
                        !_isApartmentVisible; // عكس الحالة عند الضغط
                  });
                }),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isApartmentVisible
                  ? Optiontile1(
                      title: 'Apartment type & size',
                      options: [
                        'Commercial stores',
                        'Villa',
                        'House',
                        'Gym',
                      ],
                      onSelected: (value) {
                        print("Selected: $value");
                      },
                    )
                  : SizedBox.shrink(), // إخفاء الويدجت عند عدم تفعيله
            ),

            OptionTile(
                title: 'Preferred style',
                onTap: () {
                  setState(() {
                    _isPreferredvisible =
                        !_isPreferredvisible; // عكس الحالة عند الضغط
                  });
                }),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isPreferredvisible
                  ? Optiontile2(
                      title: 'Preferred style',
                      options: [
                        'Modern',
                        'Traditional',
                        'Minimalist',
                        'Industrial',
                        'Eclectic',
                      ],
                      onSelected: (value) {
                        print("Selected: $value");
                      },
                    )
                  : SizedBox.shrink(), // إخفاء الويدجت عند عدم تفعيله
            ),
            OptionTile(
                title: 'Material quality',
                onTap: () {
                  setState(() {
                    _isMaterialQualityvisible =
                        !_isMaterialQualityvisible; // عكس الحالة عند الضغط
                  });
                }),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isMaterialQualityvisible
                  ? Optiontile2(
                      title: 'Material quality',
                      options: [
                        'High quality',
                        'Average quality',
                        'Low quality',
                      ],
                      onSelected: (value) {
                        print("Selected: $value");
                      },
                    )
                  : SizedBox.shrink(), // إخفاء الويدجت عند عدم تفعيله
            ),
            const SizedBox(height: 20),
            BudgetSlider(
              value: _budgetValue,
              onChanged: (value) {
                setState(() {
                  _budgetValue = value;
                });
              },
            ),
            const SizedBox(height: 10),
            OptionTile(
                title: 'Location',
                onTap: () {
                  setState(() {
                    _isLocationvisible =
                        !_isLocationvisible; // عكس الحالة عند الضغط
                  });
                }),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isLocationvisible
                  ? Optiontile3()
                  : SizedBox.shrink(), // إخفاء الويدجت عند عدم تفعيله
            ),
            const SizedBox(height: 10),
            ImagePicker(
                images: [
                  'assets/images/1..png',
                  'assets/images/2..png',
                  'assets/images/3..png',
                  'assets/images/1..png',
                  'assets/images/2..png',
                  'assets/images/3..png',
                ],
                onAddImage: () {
                  // open gallery
                }),
            const SizedBox(height: 10),
            DetailsInput(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Button(
                ontap: () {
                  // save data
                },
                title: 'next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
