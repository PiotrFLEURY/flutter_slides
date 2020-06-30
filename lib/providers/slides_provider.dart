import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slides/data/slide_data.dart';

class SlidesProvider with ChangeNotifier {
  List<SlideData> _slides = List();

  void loadSlides() async {
    _slides.clear();
    String value = await rootBundle.loadString("assets/slides/slides.txt");
    List<String> rawSlides = value.split("\n\n");
    rawSlides.forEach((slide) {
      String title = slide.split("\n")[0];
      String body = slide.replaceFirst("$title\n", "");
      _slides.add(SlideData(title, title == body ? "" : body));
    });
    notifyListeners();
  }

  get slides {
    if (_slides.isEmpty) {
      loadSlides();
    }
    return _slides;
  }
}
