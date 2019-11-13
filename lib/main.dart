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
  Card buildCard(String destiny, double fontsize) {
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
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image(
                                image: AssetImage('images/bus_yellow.png'),
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              Image(
                                image: AssetImage('images/arrow.png'),
                                width: 250,
                              ),
                              Image(
                                image: AssetImage('images/train_station.png'),
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//      GridView.count(
//        crossAxisCount: 1,
//        padding: EdgeInsets.all(16.0),
//        childAspectRatio: 4.0,
//        children: <Widget>[
//          Card(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(left: 15),
//                  child: Row(
//                    children: <Widget>[
//                      Image(
//                        image: AssetImage('images/bus_yellow.png'),
//                        height: 40,
//                        fit: BoxFit.cover,
//                      ),
//                      Image(
//                        image: AssetImage('images/arrow.png'),
//                        width: 250,
//                      ),
//                      Image(
//                        image: AssetImage('images/train_station.png'),
//                        height: 40,
//                        fit: BoxFit.cover,
//                      )
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
////          buildCard('IMAGE TEST', 28.0),
//          buildCard('셔틀콕', 28.0),
//          buildCard('한대앞역', 28.0),
//          buildCard('예술인 아파트', 22.0),
//          buildCard('기숙사', 28.0),
//        ],
//      ), // This trailing comma makes auto-formatting nicer for build methods.
