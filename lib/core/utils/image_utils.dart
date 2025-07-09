// import 'dart:io';
// import 'dart:typed_data';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<bool> saveImageToGallery(Uint8List bytes) async {
//    try {
//     final dir = await getTemporaryDirectory();
//     final file = File('${dir.path}/ai_furniture_${DateTime.now().millisecondsSinceEpoch}.png');
//     await file.writeAsBytes(bytes);
//     final result = await GallerySaver.saveImage(file.path);
//     return result ?? false;
//   } catch (e) {
//     print('Error saving image: $e');
//     return false;
//   }
// }
