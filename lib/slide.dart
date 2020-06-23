import 'package:flutter/material.dart';

class SlideData {
  String title;
  String content;

  SlideData(this.title, this.content);
}

class Slide extends StatelessWidget {
  static const int smallSize = 1;
  static const int bigSize = 2;

  final int sizeMode;

  final SlideData slide;

  Slide(this.sizeMode, this.slide);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/flutter-bg.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Text(
                slide.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getTitleFontSize(context),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    slide.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getContentFontSize(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double geWidth() {
    if (sizeMode == smallSize) {
      return 200;
    }
    return 800;
  }

  double getHeight() {
    if (sizeMode == smallSize) {
      return 150;
    }
    return 600;
  }

  double getTitleFontSize(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var targetSize = screenHeight / 20;
    if (sizeMode == smallSize) {
      return targetSize / 2;
    }
    return targetSize;
  }

  double getContentFontSize(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var targetSize = screenHeight / 30;
    if (sizeMode == smallSize) {
      return targetSize / 2;
    }
    return targetSize;
  }
}
