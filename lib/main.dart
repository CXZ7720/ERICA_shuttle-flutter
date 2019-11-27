import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'reusable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'api.dart';
import 'dart:async';

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
      home: MyHomePage(title: '버스 어디?'),
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
  Future<Timetable> shuttlecock_i;
  Future<Timetable> shuttlecock_o;
  Future<Timetable> giksa;
  Future<Timetable> subway;
  Future<Timetable> yesulin;

  @override
  void initState() {
    super.initState();
    shuttlecock_i = fetchData("shuttlecock_i");
    shuttlecock_o = fetchData("shuttlecock_o");
    giksa = fetchData("giksa");
    subway = fetchData("subway");
    yesulin = fetchData("yesulin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('버스어디?'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: Colors.white,
                    height: (MediaQuery.of(context).size.height) * 0.2,
                    cardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'images/bus_yellow.png',
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'images/arrow.png',
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'images/train_station.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ReusableCard(
                color: Colors.white,
                height: (MediaQuery.of(context).size.height) * 0.2,
                cardChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("셔틀콕", style: kDestinationText),
                        ],
                      ),
                    ),
                    FutureBuilder<Timetable>(
                      future: shuttlecock_o,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: <Widget>[
                              Text(snapshot.data.type, style: ktypeText),
                              Text(
                                snapshot.data.time,
                                style: kTimeText,
                              ),
                              Text(' 후 도착예정'),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: Colors.white,
                      height: (MediaQuery.of(context).size.height) * 0.2,
                      cardChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("셔틀콕\n건너편", style: kDestinationText),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FutureBuilder<Timetable>(
                            future: shuttlecock_i,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: <Widget>[
                                    Text(snapshot.data.type, style: ktypeText),
                                    Text(
                                      snapshot.data.time,
                                      style: kTimeText,
                                    ),
                                    Text(' 후 도착예정'),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: Colors.white,
                      height: (MediaQuery.of(context).size.height) * 0.2,
                      cardChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("한대앞역", style: kDestinationText),
                              ],
                            ),
                          ),
                          FutureBuilder<Timetable>(
                            future: subway,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(snapshot.data.type, style: ktypeText),
                                    Text(
                                      snapshot.data.time,
                                      style: kTimeText,
                                    ),
                                    Text(' 후 도착예정'),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: Colors.white,
                      height: (MediaQuery.of(context).size.height) * 0.2,
                      cardChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("예술인\n아파트", style: kDestinationText),
                              ],
                            ),
                          ),
                          FutureBuilder<Timetable>(
                            future: yesulin,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(snapshot.data.type, style: ktypeText),
                                    Text(
                                      snapshot.data.time,
                                      style: kTimeText,
                                    ),
                                    Text(' 후 도착예정'),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      color: Colors.white,
                      height: (MediaQuery.of(context).size.height) * 0.2,
                      cardChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("기숙사", style: kDestinationText),
                              ],
                            ),
                          ),
                          FutureBuilder<Timetable>(
                            future: giksa,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: <Widget>[
                                    Text(snapshot.data.type, style: ktypeText),
                                    Text(
                                      snapshot.data.time,
                                      style: kTimeText,
                                    ),
                                    Text(' 후 도착예정'),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
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
