import 'package:flutter/material.dart';

Widget buildImage(String image, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
  if (image.startsWith('http')) {
    // Network image
    return Image.network(
      image,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[300],
        width: width,
        height: height,
        child: const Icon(Icons.broken_image, color: Colors.red),
      ),
    );
  } else {
    // Asset image
    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[300],
        width: width,
        height: height,
        child: const Icon(Icons.broken_image, color: Colors.red),
      ),
    );
  }
}
