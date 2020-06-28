import 'package:flutter/material.dart';

class PagenationWidget extends StatefulWidget {
  PagenationWidget({Key key}) : super(key: key);

  @override
  PagenationWidgetState createState() => PagenationWidgetState();
}

@visibleForTesting
class PagenationWidgetState extends State<PagenationWidget> {
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
