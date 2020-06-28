import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';

class BigSlide extends StatelessWidget {
  final SlideData slide;

  BigSlide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
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
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.0),
                child: ListView(
                  children: formatContent(context, slide.content),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> formatContent(BuildContext context, String content) {
    return content.split('\n').map((e) => "- $e").map(
      (e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e,
            style: TextStyle(
              color: Colors.black,
              fontSize: getContentFontSize(context),
            ),
          ),
        );
      },
    ).toList();
  }

  double getTitleFontSize(context) => 32;

  double getContentFontSize(context) => 32;
}
