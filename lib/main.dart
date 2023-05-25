import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/di.dart';

void main() async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    ScreenUtilInit(
      builder: (child, context) =>
          DevicePreview(enabled: true, builder: (context) => const MyApp()),
      //DevicePreview(enabled: true,fbuilder: (context) => const MyApp()),
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    ),
  );
  await initializeDependency();
  await CacheHelper.init();
}
