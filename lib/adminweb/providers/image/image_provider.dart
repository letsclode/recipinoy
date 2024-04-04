import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_provider.g.dart';

@riverpod
ImageService image(ImageRef ref) {
  return ImageService();
}

class ImageService {
  final storage = FirebaseStorage.instance;

  String selectedFile = '';

  Uint8List? globalImage;
  Color color = Colors.red;

  void setImage(Uint8List editImage) {
    globalImage = editImage;
  }

  Future<String?> uploadImageToStorage(
      {required String recipeId, required Uint8List? image}) async {
    print("RUNNING");
    print(image);
    try {
      if (image != null) {
        Reference _reference = storage.ref().child('images/${recipeId}');
        await _reference.putData(
          image,
          SettableMetadata(contentType: 'image/jpeg'),
        );

        try {
          String downloadURL = await _reference.getDownloadURL();

          print(downloadURL);
          return downloadURL;
        } catch (error) {
          print("Error getting download URL: $error");
          return null; // Return null to indicate failure
        }
      }
    } catch (e) {
      print(e);
    }
    return null; // Return null if image is null or not on web
  }

//TODO: test this chooseimage
  Future<void> chooseImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    selectedFile = result!.files.first.name;
    globalImage = result.files.first.bytes;
    color = Colors.blue;
  }
}
