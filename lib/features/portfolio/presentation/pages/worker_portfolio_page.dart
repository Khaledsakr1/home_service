import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  static const String id = 'portfolioPage';

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<File> images = [];
  bool isLoading = false;
  bool isPickingImages = false; // Add this flag to prevent multiple simultaneous picks
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> pickImages() async {
    // Prevent multiple simultaneous image picker calls
    if (isPickingImages) return;
    
    setState(() {
      isPickingImages = true;
    });

    try {
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages.isNotEmpty) {
        final appDir = await getApplicationDocumentsDirectory();
        List<File> copiedImages = [];
        for (var img in pickedImages) {
          final file = File(img.path);
          final fileName = img.path.split('/').last;
          final newFile = await file.copy('${appDir.path}/$fileName');
          copiedImages.add(newFile);
        }
        setState(() {
          images = copiedImages;
        });
      }
    } catch (e) {
      // Handle any errors during image picking
      if (mounted) {
        showErrorOverlayMessage(context, errorMessage: 'Error picking images: ${e.toString()}');
      }
    } finally {
      setState(() {
        isPickingImages = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit, PortfolioState>(
      listener: (context, state) {
        if (state is PortfolioLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is PortfolioActionSuccess) {
          setState(() {
            isLoading = false;
          });
          showCustomOverlayMessage(context, message: state.message, subMessage: 'Your portfolio has been added successfully.');
          Navigator.pop(context, true);
        } else if (state is PortfolioError) {
          setState(() {
            isLoading = false;
          });
          showErrorOverlayMessage(context, errorMessage: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Portfolio details', style: TextStyle(color: Colors.white)),
              backgroundColor: kPrimaryColor,
              elevation: 0,
              leading: const BackButton(color: Colors.white),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    Textfield(
                      title: 'Project name',
                      headtextfield: 'Enter your project name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Project name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Textfield(
                      title: 'Description',
                      headtextfield: 'Enter project description',
                      controller: descriptionController,
                      inputType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: isPickingImages ? null : pickImages, // Disable tap when already picking
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12),
                          color: isPickingImages ? Colors.grey[300] : Colors.grey[200], // Visual feedback
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isPickingImages ? Icons.hourglass_empty : Icons.cloud_upload, 
                              color: isPickingImages ? Colors.grey : kPrimaryColor
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isPickingImages ? 'Picking Images...' : 'Upload Images (Optional)',
                              style: TextStyle(
                                color: isPickingImages ? Colors.grey : kPrimaryColor
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: images.map((img) => ListTile(
                        leading: const Icon(Icons.image, color: Colors.green),
                        title: Text(img.path.split('/').last),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => setState(() => images.remove(img)),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 30),
                    Button(
                      title: 'Submit',
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          // Remove the image validation requirement - images are now optional
                          context.read<PortfolioCubit>().addPortfolio(
                             name: nameController.text,
                             description: descriptionController.text,
                             images: images, // Can be empty now
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}