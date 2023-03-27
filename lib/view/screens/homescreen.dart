import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textextractionapp/core/functions/showimagepicker.dart';
import 'package:textextractionapp/view/widgets/appbar.dart';
import 'package:textextractionapp/view/widgets/displaytextswidget.dart';
import 'package:textextractionapp/view/widgets/drawer.dart';
import 'package:textextractionapp/view/widgets/imagewidget.dart';
import 'package:textextractionapp/view/widgets/noimageswidgets.dart';

import '../../controller/homescreencon.dart';
import '../../core/constants/colors.dart';
import '../../core/functions/showcopytextmenue.dart';
import '../widgets/floatingbuttonwidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UploadingImageControllerImp controller =
      Get.put(UploadingImageControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bodyColor,
        appBar: CustomAppbar(
          title: 'Text Extraction',
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onLongPress: () {
                      final copyText = controller.extractedText;
                      if (copyText != null && copyText.isNotEmpty) {
                        showCopyTextMenu(context, copyText);
                      }
                    },
                    child: Obx(() => controller.isload.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.extractedText == ''
                            ? const Text('')
                            : TextWidget(text: controller.extractedText)),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: Obx(
                      () {
                        if (controller.isload.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (controller.image == null) {
                          return NoImageWidget(
                            noimage: 'No Image Selected',
                          );
                        } else {
                          return ImageWidget(image: controller.image!);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingButtonWidget(
                heroTag: '1',
                icon: Icon(Icons.save),
                onpressed: () async {
                  await controller.uploadToServer();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingButtonWidget(
            heroTag: '2',
            icon: Icon(Icons.add_a_photo_rounded),
            onpressed: () {
              ShowImagePicker.showImageSourcePicker();
            }));
  }
}
