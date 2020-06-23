import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'slide.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SlideData> slides = List();

  PageController _pageController;
  ScrollController _scrollController;
  var _currentPage = 0;
  bool _fullScreen = false;

  var screenHeight;
  var screenWidth;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    loadSlides();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (kIsWeb && screenHeight < screenWidth) {
      return buildDeskLayout();
    }
    return buildMobileLayout();
  }

  Widget buildMobileLayout() {
    return OrientationBuilder(
      builder: (context, orientation) {
        var height = orientation == Orientation.landscape
            ? screenHeight / 4
            : screenHeight / 2;
        var drawerWidth = orientation == Orientation.landscape
            ? screenWidth * .2
            : screenWidth * .8;
        return Scaffold(
          drawer: Container(
            width: drawerWidth,
            child: Material(
              elevation: 4.0,
              child: ListView(
                controller: _scrollController,
                children: List.generate(
                  slides.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        _gotoPage(index);
                      },
                      child: SizedBox(
                        height: height,
                        width: double.infinity,
                        child: Container(
                          color: index == _currentPage
                              ? Colors.orange
                              : Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slide(Slide.smallSize, slides[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          body: buildMainSlideView(height),
        );
      },
    );
  }

  Widget buildDeskLayout() {
    var screenWidth = MediaQuery.of(context).size.width;
    var thumbListWidth = _fullScreen ? 0 : screenWidth * .2;
    var thumbItemHeight = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      body: Row(
        children: <Widget>[
          AnimatedContainer(
            height: double.infinity,
            width: thumbListWidth,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: ListView(
              controller: _scrollController,
              children: List.generate(
                slides.length,
                (index) {
                  return InkWell(
                    onTap: () => _gotoPage(index),
                    child: SizedBox(
                      height: thumbItemHeight,
                      width: double.infinity,
                      child: Container(
                        color: index == _currentPage
                            ? Colors.orange
                            : Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slide(Slide.smallSize, slides[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: buildMainSlideView(thumbItemHeight),
          ),
        ],
      ),
    );
  }

  Stack buildMainSlideView(double thumbItemHeight) {
    return Stack(
      children: [
        buildPageView(thumbItemHeight),
        buildToolbar(),
      ],
    );
  }

  Positioned buildToolbar() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(50),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_left,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () => _gotoPage(_currentPage - 1),
              ),
              IconButton(
                icon: Icon(
                  _fullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () => _toggleFullScreen(),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_right,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () => _gotoPage(_currentPage + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(double thumbItemHeight) {
    return PageView(
      onPageChanged: (index) {
        _scrollController?.animateTo(
          index * thumbItemHeight,
          duration: Duration(milliseconds: 400),
          curve: Curves.decelerate,
        );
        setState(() {
          _currentPage = index;
        });
      },
      controller: _pageController,
      children: List.generate(slides.length, (index) {
        return AnimatedContainer(
          duration: Duration(
            milliseconds: 400,
          ),
          padding: _fullScreen ? EdgeInsets.zero : EdgeInsets.all(48.0),
          child: Slide(Slide.bigSize, slides[index]),
        );
      }),
    );
  }

  void _gotoPage(index) {
    _pageController?.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.decelerate,
    );
  }

  void _toggleFullScreen() {
    setState(() {
      _fullScreen = !_fullScreen;
    });
  }

  void loadSlides() async {
    slides.clear();
    rootBundle.loadString("assets/slides/slides.txt").then((value) {
      List<String> rawSlides = value.split("\n\n");
      rawSlides.forEach((slide) {
        String title = slide.split("\n")[0];
        String body = slide.replaceFirst(title, "");
        slides.add(SlideData(title, body));
      });
      setState(() {});
    });
  }
}
