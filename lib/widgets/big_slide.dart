import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/widgets/command_line.dart';
import 'package:flutter_slides/widgets/link.dart';

const backgroundColor = const Color(0xffe5e9fa);

class BigSlide extends StatelessWidget {
  final SlideData slide;

  BigSlide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: Image.asset(
              "assets/images/flutter-bg.png",
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Builder(builder: (context) {
              if (slide.content.isEmpty) {
                return Center(
                    child: Text(
                  slide.title,
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.indigo,
                  ),
                ));
              }
              return buildNormalSlide(context);
            }),
          ),
        ],
      ),
    );
  }

  Column buildNormalSlide(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              slide.title,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: getTitleFontSize(context),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 9,
          child: Container(
            width: double.infinity,
            child: ListView(
              children: formatContent(context, slide.content),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> formatContent(BuildContext context, String content) {
    return content.split('\n').map(
      (e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              if (e.startsWith("http")) {
                return Link(e);
              } else if (e.startsWith("\$")) {
                return CommandLine(e);
              } else {
                return Text(
                  "- $e",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getContentFontSize(context),
                  ),
                );
              }
            },
          ),
        );
      },
    ).toList();
  }

  double getTitleFontSize(context) => 32;

  double getContentFontSize(context) => 32;
}
