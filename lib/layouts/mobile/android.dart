import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AndroidLayout extends StatefulWidget {
  @override
  _AndroidLayoutState createState() => _AndroidLayoutState();
}

class _AndroidLayoutState extends State<AndroidLayout> {
  var _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return buildAndroidLayout();
  }

  Widget buildAndroidLayout() {
    return ChangeNotifierProvider.value(
      value: GetIt.I.get<SlidesProvider>(),
      child: Consumer<SlidesProvider>(
        builder: (context, slidesProvider, _) {
          List<SlideData> slides = slidesProvider.slides;
          if (slides.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          final platformProvider = Provider.of<PlatformProvider>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(slides[_currentPage].title),
              actions: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        List<String> platforms = ["android", "ios", "web"];
                        return Container(
                          height: MediaQuery.of(context).size.height * .3,
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    platformProvider.choosedPlatform =
                                        platforms[index];
                                  },
                                  child: ListTile(
                                    title: Text(platforms[index]),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.android,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.autorenew,
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_currentPage < slides.length - 1) {
                    _currentPage = _currentPage + 1;
                  } else {
                    _currentPage = 0;
                  }
                });
              },
              child: Icon(
                Icons.navigate_next,
              ),
            ),
            drawer: Container(
              child: Material(
                elevation: 4.0,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: .5,
                    color: Colors.black,
                  ),
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      title: Text(slides[index].title),
                      subtitle: Text(slides[index].content),
                      trailing: Icon(Icons.chevron_right),
                    );
                  },
                ),
              ),
            ),
            body: _buildAndroidContent(slides[_currentPage]),
          );
        },
      ),
    );
  }

  Widget _buildAndroidContent(SlideData slide) {
    List<String> slideContent = slide.content.split('\n');
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.orange,
      ),
      itemCount: slideContent.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.donut_large),
          title: Text(
            slideContent[index],
          ),
        );
      },
    );
  }
}
