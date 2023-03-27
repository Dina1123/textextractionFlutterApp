import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:textextractionapp/view/screens/homescreen.dart';
import 'package:textextractionapp/view/screens/savedimages.dart';
import 'package:textextractionapp/view/screens/splashscreen.dart';

import 'core/constants/routes.dart';

List<GetPage<dynamic>> routesgetx = [
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: AppRoute.home, page: () => HomeScreen()),
  GetPage(name: AppRoute.savedimgs, page: () => SavedImagesScreen()),
];
