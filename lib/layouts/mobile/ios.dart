import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/providers/page_provider.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';

class IOSLayout extends StatelessWidget {
  final PlatformProvider platformProvider;
  final SlidesProvider slidesProvider;
  final PageProvider pageProvider;

  IOSLayout(this.platformProvider, this.slidesProvider, this.pageProvider);

  @override
  Widget build(BuildContext context) {
    List<SlideData> slides = slidesProvider.slides;
    final _currentPage = pageProvider.currentPage;
    if (slides.isEmpty) {
      return Center(child: CupertinoActivityIndicator());
    }
    PageController pageController = PageController(initialPage: _currentPage);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(slides[_currentPage].title),
        trailing: GestureDetector(
          onTap: () {
            pageProvider.currentPage = 0;
            pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,
            );
          },
          child: Text("Refresh"),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  pageProvider.currentPage = index;
                },
                children: List.generate(
                  slides.length,
                  (index) => _buildIOSContent(slides[index]),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  CupertinoButton(
                    onPressed: () async {
                      var selectedValue = 0;
                      await showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * .30,
                            child: CupertinoPicker.builder(
                              backgroundColor: Colors.white,
                              itemExtent: 24,
                              onSelectedItemChanged: (index) {
                                selectedValue = index;
                              },
                              childCount: slides.length,
                              itemBuilder: (context, index) {
                                return Text(slides[index].title);
                              },
                            ),
                          );
                        },
                      );
                      pageProvider.currentPage = selectedValue;
                      pageController.animateToPage(
                        _currentPage,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.decelerate,
                      );
                    },
                    child: Text("Choose slide"),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * .3,
                            child: CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    platformProvider.choosedPlatform =
                                        "android";
                                  },
                                  child: Text("android"),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    platformProvider.choosedPlatform = "ios";
                                  },
                                  child: Text("ios"),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    platformProvider.choosedPlatform = "web";
                                  },
                                  child: Text("web"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text("Choose platform"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIOSContent(SlideData slide) {
    List<String> slideContent = slide.content.split('\n');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(
            slideContent.length,
            (index) => Text(
                  slideContent[index],
                )),
      ),
    );
  }
}
