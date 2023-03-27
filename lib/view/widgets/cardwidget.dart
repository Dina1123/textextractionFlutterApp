import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.image,
      required this.text,
      required this.onpressed});
  String image;
  String text;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bodyColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.45,
              width: Get.width * 0.65,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onpressed,
                  child: const Icon(
                    Icons.delete,
                    color: AppColors.appbarbuttonsColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  color: AppColors.appbarbuttonsColor,
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: text),
                    );
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
