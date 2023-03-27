import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({
    super.key,
    required this.image,
  });
  File image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.5,
          width: Get.width * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                image: FileImage(
                  image,
                ),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
