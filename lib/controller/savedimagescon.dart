import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:textextractionapp/applinks.dart';
import 'package:textextractionapp/data/models/imagesmodel.dart';

import '../core/constants/colors.dart';

abstract class SavedImagesController extends GetxController {
  final _savedImages = <File>[].obs;
  List<File> get savedImages => _savedImages;
  fetchData();
  removeImage(int id);
  var data = <ImageModel>[].obs;
  var isDataEmpty = false.obs;
  var isLoading = false.obs;
}

class SavedImagesControllerImp extends SavedImagesController {
  var statusMessage = "".obs;
  @override
  Future<void> removeImage(int id) async {
    try {
      isLoading.value = true;
      // Show confirmation dialog to the user
      bool confirmed = await Get.defaultDialog(
        backgroundColor: AppColors.appbarbuttonsColor,
        title: "Confirm",
        titleStyle: TextStyle(color: AppColors.bodyColor),
        content: const Text(
          "Are you sure you want to delete this image?",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.bodyColor),
        ),
        confirm: TextButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.bodyColor)),
          autofocus: true,
          onPressed: () => Get.back(result: true),
          child: const Text(
            "Yes",
            style: TextStyle(color: AppColors.appbarbuttonsColor),
          ),
        ),
        cancel: TextButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.bodyColor)),
          autofocus: true,
          onPressed: () => Get.back(result: false),
          child: const Text(
            "No",
            style: TextStyle(color: AppColors.appbarbuttonsColor),
          ),
        ),
      );
      if (confirmed) {
        var response = await http.post(Uri.parse(AppLinks.deleteserver),
            body: {'id': id.toString()});
        if (response.statusCode == 200) {
          statusMessage.value = "User deleted successfully!";
          Get.snackbar(
            "Success",
            "Image Deleted Successfully",
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
                AppColors.greenColor,
                AppColors.pinkColor,
                AppColors.appbarbuttonsColor
              ],
            ),
          );
          isLoading(false);
          fetchData();
        }
      } else {
        isLoading(false);
      }
    } catch (e) {
      // Get.snackbar("Error: $e", "Failed to delete image");
      isLoading(false);
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(AppLinks.getserver));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'success') {
          Get.snackbar(
            "Refreshed",
            "Images Refreshed Successfully",
            duration: Duration(seconds: 1),
            icon: const Icon(
              Icons.check_box_rounded,
              color: AppColors.greenColor,
            ),
            colorText: AppColors.bodyColorWhite,
            snackPosition: SnackPosition.BOTTOM,
            backgroundGradient: const LinearGradient(
              colors: [
                Colors.blue,
                AppColors.appbarbuttonsColor,
                AppColors.greenColor,
                AppColors.pinkColor,
                AppColors.appbarbuttonsColor
              ],
            ),
          );
          isLoading.value = false;
          List<dynamic> dataList = jsonResponse['data'];
          List<ImageModel> imagesList =
              dataList.map((data) => ImageModel.fromJson(data)).toList();
          data.assignAll(imagesList);
        } else {
          Get.snackbar("Error", "Failed to load image");
        }
      } else {
        Get.snackbar("Error", "Failed to load images");
      }
    } catch (e) {
      Get.snackbar("Error: $e", "Failed to load images");
    } finally {
      isLoading.value = false;
    }
  }
}
