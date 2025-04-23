import 'package:flutter/material.dart';
import 'package:home_service/widgets/BudgetSlider.dart';
import 'package:home_service/widgets/ImagePicker.dart';
import 'package:home_service/widgets/Optiontile.dart';
import 'package:home_service/widgets/TextField2.dart';
import 'package:home_service/widgets/button.dart';

class Startnewproject extends StatefulWidget {
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<Startnewproject> {
  double _budgetValue = 100000;

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
            OptionTile(title: 'type of service'),
            OptionTile(title: 'Apartment type & size'),
            OptionTile(title: 'Preferred style'),
            OptionTile(title: 'Material quality'),
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
            OptionTile(title: 'Location'),
            const SizedBox(height: 10),
            _buildImagePicker(),
            const SizedBox(height: 10),
            _buildDetailsInput(),
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

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Add images (optional)"),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _imagePreview("assets/images/sample1.jpg"),
              _imagePreview("assets/images/sample2.jpg"),
              _imagePreview("assets/images/sample3.jpg"),
              _addImageButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _imagePreview(String path) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget _addImageButton() {
    return GestureDetector(
      onTap: () {
        // افتح معرض الصور أو الكاميرا
      },
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add, color: Colors.green),
      ),
    );
  }

  Widget _buildDetailsInput() {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Specify the details of what you want.",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
