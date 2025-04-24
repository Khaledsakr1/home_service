import 'package:flutter/material.dart';
import 'package:home_service/widgets/BudgetSlider.dart';
import 'package:home_service/widgets/DetailsInput.dart';
import 'package:home_service/widgets/ImagePicker.dart';
import 'package:home_service/widgets/Optiontile.dart';
import 'package:home_service/widgets/Optiontile1.dart';
import 'package:home_service/widgets/TextField2.dart';
import 'package:home_service/widgets/button.dart';

class Startnewproject extends StatefulWidget {
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<Startnewproject> {
  double _budgetValue = 100000;
  bool _isVisible = false; // للتحكم في ظهور الويدجت

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Start a New Project",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(
          color: Colors.green,
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
                  _isVisible = !_isVisible; // عكس الحالة عند الضغط
                });
              },
            ),
            
            // الويدجت الذي سيظهر عند الضغط على "Type of service"
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isVisible
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
              onTap: () {},
            ),
            OptionTile(
              title: 'Preferred style',
              onTap: () {},
            ),
            OptionTile(
              title: 'Material quality',
              onTap: () {},
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
              onTap: () {},
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
