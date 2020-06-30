import 'package:flutter/material.dart';

class CommandLine extends StatelessWidget {
  final String command;

  CommandLine(this.command);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
      ),
      padding: EdgeInsets.all(8.0),
      child: Text(
        command,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
