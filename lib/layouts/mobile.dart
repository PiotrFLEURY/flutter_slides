import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slides/layouts/mobile/android.dart';
import 'package:flutter_slides/layouts/mobile/ios.dart';

class MobileLayout extends StatefulWidget {
  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidLayout();
    } else {
      return IOSLayout();
    }
  }
}
