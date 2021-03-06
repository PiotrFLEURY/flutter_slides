import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/providers/page_provider.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:flutter_slides/widgets/big_slide.dart';
import 'package:flutter_slides/widgets/small_slide.dart';

class DesktopLayout extends StatefulWidget {
  final PlatformProvider platformProvider;
  final SlidesProvider slidesProvider;
  final PageProvider pageProvider;

  DesktopLayout(this.platformProvider, this.slidesProvider, this.pageProvider);

  @override
  _DesktopLayoutState createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  PageController _pageController;
  ScrollController _scrollController;

  bool _fullScreen = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var thumbListWidth = _fullScreen ? 0 : screenWidth * .1;
    var thumbItemHeight = MediaQuery.of(context).size.height / 8;
    final slides = widget.slidesProvider.slides;
    final currentPage = widget.pageProvider.currentPage;
    _pageController = PageController(initialPage: currentPage);
    return Scaffold(
      body: Row(
        children: <Widget>[
          AnimatedContainer(
            height: double.infinity,
            width: thumbListWidth.toDouble(),
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
                        color: index == currentPage
                            ? Colors.blue
                            : Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SmallSlide(slides[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: buildMainSlideView(widget.pageProvider,
                widget.platformProvider, currentPage, slides, thumbItemHeight),
          ),
        ],
      ),
    );
  }

  Stack buildMainSlideView(
      PageProvider pageProvider,
      PlatformProvider platformProvider,
      int currentPage,
      List<SlideData> slides,
      double thumbItemHeight) {
    return Stack(
      children: [
        buildPageView(pageProvider, slides, thumbItemHeight),
        buildToolbar(platformProvider, pageProvider),
      ],
    );
  }

  Positioned buildToolbar(
      PlatformProvider platformProvider, PageProvider pageProvider) {
    final currentPage = pageProvider.currentPage;
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
                  Icons.android,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () {
                  platformProvider.choosedPlatform = "android";
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.mobile_screen_share,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () {
                  platformProvider.choosedPlatform = "ios";
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_left,
                ),
                color: _fullScreen ? Colors.white : Colors.black,
                onPressed: () => _gotoPage(currentPage - 1),
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
                onPressed: () => _gotoPage(currentPage + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(PageProvider pageProvider, List<SlideData> slides,
      double thumbItemHeight) {
    return PageView(
      onPageChanged: (index) {
        setState(() {
          pageProvider.currentPage = index;
        });
      },
      controller: _pageController,
      children: List.generate(slides.length, (index) {
        return AnimatedContainer(
          duration: Duration(
            milliseconds: 400,
          ),
          padding: _fullScreen ? EdgeInsets.zero : EdgeInsets.all(48.0),
          child: BigSlide(slides[index]),
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
}
