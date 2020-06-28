import 'package:flutter/material.dart';

class PagenationWidget extends StatefulWidget {
  PagenationWidget({Key key}) : super(key: key);

  @override
  _PagenationWidgetState createState() => _PagenationWidgetState();
}

class _PagenationWidgetState extends State<PagenationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      child: Row(),
      color: Colors.blue,
    );
  }
}
