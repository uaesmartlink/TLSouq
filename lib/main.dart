import 'package:TLSouq/src/screen/cart/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/bindings/init_bindings.dart';
import 'src/controllers/init_controller.dart';
import 'src/_route/routes.dart';
import 'src/data/data_storage_service.dart';
import 'src/languages/language_translation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request all required permissions
  await [
    Permission.storage,
    Permission.requestInstallPackages,
    Permission.accessMediaLocation,
    Permission.notification,
    Permission.location,
    Permission.locationAlways,
    Permission.locationWhenInUse,
    // Add more permissions here
  ].request();
  LocationPermission permission;
  permission = await Geolocator.requestPermission();
  // Check if any permissions are denied

  await initialConfig();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final storage = Get.put(StorageService());
  final initController = Get.put(InitController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        // return MaterialApp(
        //   title: 'Google Map Test',
        //   home: MapSample(),
        // );
        return GetMaterialApp(
          navigatorObservers: <NavigatorObserver>[initController.observer],
          initialBinding: InitBindings(),
          locale: storage.languageCode != null
              ? Locale(storage.languageCode!, storage.countryCode)
              : const Locale('en', 'US'),
          translations: AppTranslations(),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Routes.splashScreen,
          getPages: Routes.list,
        );
      },
    );
  }
}
