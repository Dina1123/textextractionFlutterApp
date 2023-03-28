import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../applinks.dart';
import '../core/constants/colors.dart';

abstract class UploadingImageController extends GetxController {
  final _imageFile = Rx<File?>(null);
  final _extractedText = RxString('');
  File? get image => _imageFile.value;
  String get extractedText => _extractedText.value;
  final _savedImages = <File>[].obs;
  List<File> get savedImages => _savedImages;

  final serverUrl = AppLinks.postserver;

  // 'http://192.168.43.66/TextExtraction/test.php'
  uploadToServer();
}

class UploadingImageControllerImp extends UploadingImageController {
  var isload = false.obs;
  @override
  uploadfromgallery() async {
    try {
      isload.value = true;
      update();

      final imagePicker = ImagePicker();

      final pickedFile =
          await imagePicker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final inputImage = InputImage.fromFile(imageFile);
        final textDetector = GoogleMlKit.vision.textRecognizer();
        final recognisedText = await textDetector.processImage(inputImage);
        _imageFile.value = imageFile;
        _extractedText.value = recognisedText.text;
      } else {
        Get.snackbar("Error", "Faileeeeed to select image");
      }
    } catch (e) {
      Get.snackbar("Error= $e", "Failed to select image");
    } finally {
      isload.value = false;
      update();
    }
  }

  @override
  takePicture() async {
    try {
      isload.value = true;
      update();

      final imagePicker = ImagePicker();

      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final inputImage = InputImage.fromFile(imageFile);
        final textDetector = GoogleMlKit.vision.textRecognizer();
        final recognisedText = await textDetector.processImage(inputImage);
        _imageFile.value = imageFile;
        _extractedText.value = recognisedText.text;
      } else {
        Get.snackbar("Error", "Failed to select image");
      }
    } catch (e) {
      Get.snackbar("Error= $e", "Failed to select image");
    } finally {
      isload.value = false;
      update();
    }
  }

  @override
  Future<void> uploadToServer() async {
    try {
      isload.value = true;
      update();

      if (_imageFile.value != null) {
        final request = http.MultipartRequest('POST', Uri.parse(serverUrl));
        request.files.add(http.MultipartFile.fromBytes(
            'images', await _imageFile.value!.readAsBytes(),
            filename: _imageFile.value!.path.split('/').last));
        request.fields['texts'] = extractedText;
        final response = await request.send();
        if (response.statusCode == 200) {
          Get.snackbar(
            "Success",
            "Image Saved Successfully",
            icon: const Icon(
              Icons.check_box_rounded,
              color: AppColors.greenColor,
            ),
            colorText: AppColors.bodyColorWhite,
            snackPosition: SnackPosition.BOTTOM,
            backgroundGradient: const LinearGradient(
              colors: [
                AppColors.blueColor,
                AppColors.appbarbuttonsColor,
                AppColors.pinkColor,
                AppColors.greenColor
              ],
            ),
          );
        } else {
          Get.snackbar("Error", "Failed to select image");
        }
      } else {
        Get.snackbar("Error", "Failed to select image");
      }
    } catch (e) {
      Get.snackbar("Error= $e", "Failed to select image");
    } finally {
      isload.value = false;
      update();
    }
  }
}
