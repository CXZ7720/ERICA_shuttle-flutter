import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '셔틀콕'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

Card buildCard(String destiny, double fontsize){
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$destiny',
            style: TextStyle(
              fontFamily: 'Spoqa Han sans',
              fontSize: fontsize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 4.0,
        children: <Widget>[
          buildCard('IMAGE TEST', 28.0),
          buildCard('셔틀콕', 28.0),
          buildCard('한대앞역', 28.0),
          buildCard('예술인 아파트', 22.0),
          buildCard('기숙사', 28.0),

        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
