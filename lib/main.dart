import 'package:flutter/material.dart';
import 'package:flutter_vgu/ui/card.dart';

import 'api/network.dart';
import 'models/news_model.dart';

void main() {
  getData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VGU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildListSliver(snapshot.data, context);
          } else if (snapshot.hashCode.toString() == 'apiKeyMissing') {
            return Center(
              child: Text('Oppps! Error server'),
            );
          } else {
            return Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildListSliver(NewsModel values, BuildContext context) {
    if (values.articles.length == 0) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text('You didn\'t like anything',
                style: TextStyle(color: Theme.of(context).accentColor, fontSize: 24))),
      );
    } else {
      return ListView(
        children: values.articles.map((k) => ListItem(k)).toList(),
      );
    }
  }
}
