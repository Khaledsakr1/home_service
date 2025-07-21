import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final List<String> images;
  final List<String>? networkImages;
  final void Function() onAddImage;
  final void Function(int index)? onRemoveImage;
  final void Function(int index)? onRemoveNetworkImage;

  const ImagePickerWidget({
    Key? key,
    required this.images,
    this.networkImages,
    required this.onAddImage,
    this.onRemoveImage,
    this.onRemoveNetworkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final netImgs = networkImages ?? [];
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Add images (optional)"),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...netImgs.asMap().entries.map((entry) => _networkImagePreview(entry.value, entry.key)),
                ...images.asMap().entries.map((entry) => _imagePreview(entry.value, entry.key)),
                _addImageButton(onAddImage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkImagePreview(String url, int index) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
        if (onRemoveNetworkImage != null)
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => onRemoveNetworkImage!(index),
              child: const Icon(Icons.cancel, color: Colors.red, size: 20),
            ),
          )
      ],
    );
  }

  Widget _imagePreview(String path, int index) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover),
          ),
        ),
        if (onRemoveImage != null)
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => onRemoveImage!(index),
              child: const Icon(Icons.cancel, color: Colors.red, size: 20),
            ),
          )
      ],
    );
  }

  Widget _addImageButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add, color: Colors.green),
      ),
    );
  }
}
