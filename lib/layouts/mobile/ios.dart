import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class IOSLayout extends StatefulWidget {
  @override
  _IOSLayoutState createState() => _IOSLayoutState();
}

class _IOSLayoutState extends State<IOSLayout> {
  var _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return buildIOSLayout();
  }

  Widget buildIOSLayout() {
    final platformProvider = Provider.of<PlatformProvider>(context);
    return ChangeNotifierProvider.value(
      value: GetIt.I.get<SlidesProvider>(),
      child: Consumer<SlidesProvider>(
        builder: (context, slidesProvider, _) {
          List<SlideData> slides = slidesProvider.slides;
          if (slides.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          }
          PageController pageController =
              PageController(initialPage: _currentPage);
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(slides[_currentPage].title),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentPage = 0;
                    pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                    );
                  });
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
                        setState(() {
                          _currentPage = index;
                        });
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
                                  height:
                                      MediaQuery.of(context).size.height * .30,
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
                            setState(() {
                              _currentPage = selectedValue;
                              pageController.animateToPage(
                                _currentPage,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.decelerate,
                              );
                            });
                          },
                          child: Text("Choose slide"),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
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
                                          platformProvider.choosedPlatform =
                                              "ios";
                                        },
                                        child: Text("ios"),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          platformProvider.choosedPlatform =
                                              "web";
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
        },
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
