import 'dart:async';

import 'package:HYBUS/GbisCardBuilder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bus_query.dart';
import 'components/shuttleBus_card.dart';
import 'const.dart';
import 'shuttle_query.dart';
import 'subway_query.dart';
import 'topisCardBuilder.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //make devices portrait. Prevent rotate.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'HYBUS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'HYBUS'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<String> titleNames = ["셔틀콕", "셔틀콕\n건너편", "한대앞", "예술인\n아파트", "기숙사"];
  List<String> fetchDataNames = ["shuttlecock_i", "shuttlecock_o", "subway", "yesulin", "giksa"];
  List<Future<Timetable>> fetchDataList = [];
  Future<Timetable> shuttlecock_i;
  Future<Timetable> shuttlecock_o;
  Future<Timetable> giksa;
  Future<Timetable> subway;
  Future<Timetable> yesulin;

  Future<Bus> bus_3102;
  Future<Subway> subway_4_upper;
  Future<Subway> subway_4_lower;

  final RefreshController _refreshController = RefreshController();

  AppLifecycleState _lastLifecycleState;
  Timer timer;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    monitorNetworkFetch();

    // refresh every 60 sec .
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => refreshData());
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
//    _firebaseMessaging.getToken().then((token){
//      print(token);
//    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
      if (state == AppLifecycleState.resumed) {
        // resume timer to live fetchData
        // 59sec due to `await Future.delayed(Duration(milliseconds: 1000));`
        refreshData();
        timer = Timer.periodic(Duration(seconds: 59), (Timer t) => refreshData());
      }
    });
  }

  void _onRefreshing() async {
    // monitor network fetch
    monitorNetworkFetch();

    subway_4_upper = querySubway("subway_4_upper");
    subway_4_lower = querySubway("subway_4_lower");
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  void refreshData() async {
    // when user in background, paused live fetchData
    switch (_lastLifecycleState) {
      case AppLifecycleState.inactive:
        timer.cancel();
        break;
      case AppLifecycleState.paused:
        timer.cancel();
        break;
      case AppLifecycleState.detached:
        timer.cancel();
        break;
      case AppLifecycleState.resumed:
    }
    monitorNetworkFetch();
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));
    print("새로고침");
  }

  void monitorNetworkFetch() {
    try {
      fetchDataList = [];
      shuttlecock_i = fetchData("shuttlecock_i");
      shuttlecock_o = fetchData("shuttlecock_o");
      giksa = fetchData("giksa");
      subway = fetchData("subway");
      yesulin = fetchData("yesulin");
      bus_3102 = queryBus("216000379");
      fetchDataList.add(shuttlecock_i);
      fetchDataList.add(shuttlecock_o);
      fetchDataList.add(giksa);
      fetchDataList.add(subway);
      fetchDataList.add(yesulin);
      subway_4_upper = querySubway("subway_4_upper");
      subway_4_lower = querySubway("subway_4_lower"); //4호선. 추후 수인선 개통시 파라미터만 바꿔서 호출.

      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text('HYBUS', style: kAppbarText),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.blue[100].withOpacity(0.8)),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropMaterialHeader(),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            _onRefreshing();
            _refreshController.refreshCompleted();
          },
//        onLoading: _onRefreshing,
          child: Column(
            children: <Widget>[
              CarouselSlider(
                height: 100.0,
                items: [
                  BUS_3102(bus_3102: bus_3102),
                  SUBWAY_4(subway_4: subway_4_upper), //상행선
                  SUBWAY_4(subway_4: subway_4_lower), //하행선
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: i,
                      );
                    },
                  );
                }).toList(),
              ),
//            BUS_3102(bus_3102: bus_3102),
              Expanded(
                child: ListView(
                  children: List.generate(
                    titleNames.length,
                    (index) => ShuttleBusCard(
                      key: ValueKey(index),
                      title: titleNames[index],
                      fetchedData: fetchDataList[index],
                      index: index,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
