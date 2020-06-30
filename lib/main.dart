import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slides/layouts/desk.dart';
import 'package:flutter_slides/layouts/mobile/android.dart';
import 'package:flutter_slides/layouts/mobile/ios.dart';
import 'package:flutter_slides/providers/page_provider.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SlidesProvider()),
        ChangeNotifierProvider(create: (_) => PlatformProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
      ],
      child: Consumer3<SlidesProvider, PlatformProvider, PageProvider>(
        builder: (context, slidesProvider, platformProvider, pageProvider, _) {
          final choosedPlatform = platformProvider.choosedPlatform;

          if (choosedPlatform == "android") {
            return MaterialApp(
              home:
                  AndroidLayout(platformProvider, slidesProvider, pageProvider),
            );
          } else if (choosedPlatform == "ios") {
            return CupertinoApp(
              home: IOSLayout(platformProvider, slidesProvider, pageProvider),
            );
          } else {
            return MaterialApp(
              home: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;
                  if (screenHeight > screenWidth) {
                    return AndroidLayout(
                        platformProvider, slidesProvider, pageProvider);
                  } else {
                    return DesktopLayout(
                        platformProvider, slidesProvider, pageProvider);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
