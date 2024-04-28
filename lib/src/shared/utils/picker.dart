import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image_reduce;

Future<String?> pickImage({required bool isCamera}) async {
  if (isCamera) {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      // Resize the image
      image_reduce.Image image =
          image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
      image_reduce.copyResize(image, width: 500);

      // Compress and save the image
      final compressedImage = File('$path/img_$image.jpg')
        ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

      // Upload the image to Firebase Storage
      final imageUrl = compressedImage.path;
      return imageUrl;
    }
  } else {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Check if the file has a valid image extension
      final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      final String extension = pickedFile.path.split('.').last.toLowerCase();
      if (!validExtensions.contains(extension)) {
        throw Exception('Only allowed extensions are jpg, jpeg, png, and gif.');
      }

      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      final File imageFile = File(pickedFile.path);
      final image_reduce.Image image =
          image_reduce.decodeImage(imageFile.readAsBytesSync())!;

      // Resize the image
      final image_reduce.Image resizedImage =
          image_reduce.copyResize(image, width: 500);

      // Compress and save the image
      final compressedImageFile = File('$path/img_$image.$extension')
        ..writeAsBytesSync(image_reduce.encodeJpg(resizedImage, quality: 85));

      // Upload the image to Firebase Storage
      final imageUrl = compressedImageFile.path;
      return imageUrl;
    }
  }
  return null;
}
