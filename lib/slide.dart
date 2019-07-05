import 'package:flutter/material.dart';

class SlideData {
  String title;
  String content;

  SlideData(this.title, this.content);

}

class Slide extends StatelessWidget {

  static const int smallSize = 1;
  static const int bigSize = 2;

  int sizeMode;

  SlideData slide;

  Slide(this.sizeMode, this.slide);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Container(
        width: geWidth(),
        height: getHeight(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/flutter-bg.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Text(slide.title, style: TextStyle(color: Colors.white, fontSize: getTitleFontSize()),),
              Expanded(
                child: Center(
                  child: Text(slide.content, style: TextStyle(color: Colors.white, fontSize: getContentFontSize()),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double geWidth() {
    if(sizeMode == smallSize) {
      return 200;
    }
    return 800;
  }

  double getHeight() {
    if(sizeMode == smallSize) {
      return 150;
    }
    return 600;
  }

  double getTitleFontSize() {
    if(sizeMode == smallSize) {
      return 25;
    }
    return 100;
  }

  double getContentFontSize() {
    if(sizeMode == smallSize) {
      return 8;
    }
    return 32;
  }
}
