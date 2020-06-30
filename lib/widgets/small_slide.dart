import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';

class SmallSlide extends StatelessWidget {
  final SlideData slide;

  SmallSlide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          slide.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withAlpha(200),
            fontSize: getTitleFontSize(context),
          ),
        ),
      ),
    );
  }

  double getTitleFontSize(context) => 16;
}
