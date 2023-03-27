import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textextractionapp/controller/savedimagescon.dart';
import 'package:textextractionapp/view/widgets/appbar.dart';
import 'package:textextractionapp/view/screens/loading.dart';
import 'package:textextractionapp/view/widgets/floatingbuttonwidget.dart';
import 'package:textextractionapp/view/widgets/noimageswidgets.dart';

import '../../applinks.dart';
import '../../core/constants/colors.dart';
import '../widgets/cardwidget.dart';
import 'imagedetailedscreen.dart';

class SavedImagesScreen extends StatefulWidget {
  @override
  State<SavedImagesScreen> createState() => _SavedImagesScreenState();
}

class _SavedImagesScreenState extends State<SavedImagesScreen> {
  SavedImagesControllerImp controller = Get.put(SavedImagesControllerImp());
  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bodyColor,
        appBar: CustomAppbar(title: 'Images'),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(child: LoadingScreen());
            } else if (controller.data.isEmpty) {
              return Center(
                child: NoImageWidget(noimage: 'There are no images!'),
              );
            } else {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (BuildContext context, int id) {
                      final item = controller.data[id];
                      final String imageUrl =
                          '${AppLinks.imageuploadserver}${item.images}';
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ImageDetailScreen(image: item));
                        },
                        child: CustomCard(
                          image: imageUrl,
                          text: item.texts,
                          onpressed: () {
                            controller.removeImage(item.id);
                          },
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: FloatingButtonWidget(
                      heroTag: '1',
                      icon: const Icon(Icons.refresh),
                      onpressed: () {
                        if (controller.isLoading.value) {
                          LoadingScreen();
                        } else {
                          controller.fetchData();
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
