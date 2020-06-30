import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String url;

  Link(this.url);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => _launchUrl(),
      child: Text(
        url,
        style: TextStyle(color: Colors.blue, fontSize: 24.0),
      ),
    );
  }

  void _launchUrl() async {
    if (await canLaunch(this.url)) {
      await launch(this.url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
