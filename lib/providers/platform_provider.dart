import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformProvider with ChangeNotifier {
  String _choosedPlatform = kIsWeb ? "web" : Platform.operatingSystem;

  get choosedPlatform => _choosedPlatform;

  set choosedPlatform(String choice) {
    _choosedPlatform = choice;
    notifyListeners();
  }
}
