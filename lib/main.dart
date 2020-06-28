import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slides/layouts/desk.dart';
import 'package:flutter_slides/layouts/mobile/android.dart';
import 'package:flutter_slides/layouts/mobile/ios.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt.I.registerSingleton(SlidesProvider());
  GetIt.I.registerSingleton(PlatformProvider());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GetIt.I.get<PlatformProvider>(),
      child: Consumer<PlatformProvider>(
        builder: (context, platformProvider, _) {
          final choosedPlatform = platformProvider.choosedPlatform;
          if (choosedPlatform == "ios") {
            return CupertinoApp(
              home: IOSLayout(),
            );
          } else if (choosedPlatform == "android") {
            return MaterialApp(
              home: AndroidLayout(),
            );
          } else if (choosedPlatform == "web") {
            return MaterialApp(
              home: DesktopLayout(),
            );
          } else
            return MaterialApp(
              home: MyHomePage(),
            );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (kIsWeb && screenHeight < screenWidth) {
      return DesktopLayout();
    }
    return AndroidLayout();
  }
}
