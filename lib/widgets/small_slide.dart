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
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.indigo,
      ),
      child: Center(
        child: Text(
          slide.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: getTitleFontSize(context),
          ),
        ),
      ),
    );
  }

  double getTitleFontSize(context) => 16;
}
