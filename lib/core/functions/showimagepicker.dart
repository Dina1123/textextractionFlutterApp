import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/homescreencon.dart';

class ShowImagePicker {
  static void showImageSourcePicker() async {
    UploadingImageControllerImp controller =
        Get.put(UploadingImageControllerImp());
    showModalBottomSheet(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture from camera'),
                onTap: () async {
                  Get.back();
                  await controller.takePicture();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Get.back();
                  await controller.uploadfromgallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
