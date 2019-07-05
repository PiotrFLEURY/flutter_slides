import 'package:flutter/material.dart';
import 'slide.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SlideData> slides = List();

  @override
  void initState() {
    super.initState();
    loadSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 250,
            child: ListView(
                children: List.generate(slides.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slide(Slide.smallSize, slides[index]),
              );
            })),
          ),
          Expanded(
            child: PageView(
              children: List.generate(slides.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Slide(Slide.bigSize, slides[index]),
                );
              }),
            ),
          ),
        ],
      ),
    );
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
