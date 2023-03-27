import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'colors.dart';

ThemeData myTheme = ThemeData(
  fontFamily: 'PlayfairDisplay',
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppColors.bodyColorWhite),
    bodyText1: TextStyle(color: AppColors.bodyColorBlack),
  ),
);
