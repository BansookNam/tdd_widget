import 'package:flutter/material.dart';

import 'package:tdd_widget/network/mock_api.dart';
import 'package:tdd_widget/widget/w_pagenation_complete.dart';

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
      home: MyHomePage(title: 'Test-Driven Widget Development'),
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
  MockRepository repository = MockRepository();
  List<num> list;
  int currentPage = 1;
  int totalCount = 0;
  bool isLoading = false;
  static const int limit = 5;
  @override
  void initState() {
    super.initState();

    requesetData();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: isLoading ? Colors.grey.withOpacity(0.5) : Colors.transparent,
                child: isLoading ? Center(child: CircularProgressIndicator()) : Container()),
            list == null
                ? Container()
                : Container(
                    height: 350,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              ...(list
                                  .map((item) => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              item.toString(),
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList())
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PagenationWidgetComplete(
                              totalItemCount: totalCount,
                              currentPage: currentPage,
                              onTapPage: (page) {
                                setState(() {
                                  currentPage = page;
                                  requesetData();
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void requesetData() async {
    setState(() {
      isLoading = true;
    });
    final response = await repository.getNumbers(currentPage, limit);
    setState(() {
      isLoading = false;
      list = response.numList;
      totalCount = response.totalCount;
    });
  }
}
