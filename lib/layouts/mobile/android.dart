import 'package:flutter/material.dart';
import 'package:flutter_slides/data/slide_data.dart';
import 'package:flutter_slides/providers/page_provider.dart';
import 'package:flutter_slides/providers/platform_provider.dart';
import 'package:flutter_slides/providers/slides_provider.dart';
import 'package:flutter_slides/widgets/link.dart';

class AndroidLayout extends StatelessWidget {
  final PlatformProvider platformProvider;
  final SlidesProvider slidesProvider;
  final PageProvider pageProvider;

  AndroidLayout(this.platformProvider, this.slidesProvider, this.pageProvider);

  @override
  Widget build(BuildContext context) {
    List<SlideData> slides = slidesProvider.slides;
    if (slides.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    final _currentPage = pageProvider.currentPage;
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
              pageProvider.currentPage = 0;
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
          if (_currentPage < slides.length - 1) {
            pageProvider.currentPage = _currentPage + 1;
          } else {
            pageProvider.currentPage = 0;
          }
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
                  pageProvider.currentPage = index;
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
  }

  Widget _buildAndroidContent(SlideData slide) {
    List<String> slideContent = slide.content.split('\n');
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.orange,
      ),
      itemCount: slideContent.length,
      itemBuilder: (context, index) {
        var text = slideContent[index];
        return ListTile(
          leading: Icon(Icons.donut_large),
          title: text.startsWith("http")
              ? Link(text)
              : Text(
                  text,
                ),
        );
      },
    );
  }
}
