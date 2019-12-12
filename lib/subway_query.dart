import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

getTopisKey() async {
  try {
    String keyURL =
        'https://gist.githubusercontent.com/CXZ7720/325fec757b4d1ca57a1e536f673e319b/raw/ef690d0b94b6601d167a1928348c9aa85ad14a95/TOPIS_API_KEY';
    final key = await http.read(keyURL);
//    print("key == " + key);
    return key.toString();
  } catch (e) {
    print(e);
  }
}

getSubwayData() async {
  var key = await getTopisKey();
  final Map<String, dynamic> parsedData = {
    "upper_dest": "", //상행선 종착역
    "upper_trainLineNm": "", //상행선 열차종류("당고개행 - 상록수방면")
    "upper_current": "", //상행선 현위치
    "upper_arvlMsg2": "", // 하행선 도차메시지([2]전역 안산)

    "lower_dest": "", // 하행선 종착역
    "upper_trainLineNm": "", //하행선 열차종류("오이도행 - 중앙방면")
    "lower_current": "", //하행선 현위치
    "lower_arvlMsg2": "", //하행선 도착메세지([1]전역 상록수)
  };
//  final Xml2Json trans = Xml2Json();
  print(key);
  try {
    var url = 'http://swopenapi.seoul.go.kr/api/subway/' +
        key.toString() +
        '/json/realtimeStationArrival/0/5/%ED%95%9C%EB%8C%80%EC%95%9E';
    print(url);
//    var response = await http.read(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> subwayList = json.decode(response.body);
      if (subwayList[0]['status'] == 200) {
        //정상운행중
        parsedData["upper_dest"] = subwayList[1][0]['bstatnNm']; //당고개행
        parsedData["upper_trainLineNm"] =
            subwayList[1][0]['trainLineNm']; //당고개행 - 상록수방면 : 둘 중에 하나 골라서 사용.
        parsedData["upper_current"] = subwayList[1][0]['arvlMsg3']; //안산
        parsedData["upper_arvlMsg2"] = subwayList[1][0]['arvlMsg2']; //[2]전역 안산

        parsedData["lower_dest"] = subwayList[1][0]['bstatnNm']; //오이도행
        parsedData["lower_trainLineNm"] =
            subwayList[1][0]['trainLineNm']; //오이도행 - 상록수방면 : 둘 중에 하나 골라서 사용.
        parsedData["lower_current"] = subwayList[1][0]['arvlMsg3']; //상록수
        parsedData["lower_arvlMsg2"] = subwayList[1][0]['arvlMsg2']; //[1]전역 상록수

      }
    }

    return parsedData;
  } catch (e) {
    print("An error occured!");
    print(e);
  }
}

class Bus {
  final String upper_dest;
  final String upper_trainLineNm;
  final String upper_current;
  final String upper_arvlMsg2;

  final String lower_dest;
  final String lower_trainLineNm;
  final String lower_current;
  final String lower_arvlMsg2;

  Bus({
    this.upper_dest,
    this.upper_trainLineNm,
    this.upper_current,
    this.upper_arvlMsg2,
    this.lower_dest,
    this.lower_trainLineNm,
    this.lower_current,
    this.lower_arvlMsg2,
  });

  factory Bus.fromMap(Map<String, String> data) {
    return Bus(
      upper_dest: data['upper_dest'],
      upper_trainLineNm: data['upper_trainLineNm'],
      upper_current: data['upper_current'],
      upper_arvlMsg2: data['upper_arvlMsg2'],
      lower_dest: data['upper_dest'],
      lower_trainLineNm: data['upper_trainLineNm'],
      lower_current: data['upper_current'],
      lower_arvlMsg2: data['upper_arvlMsg2'],
    );
  }
}

Future<Bus> queryBus() async {
  final Map train_response = await getSubwayData();
  print("!!!!" + train_response['predictTime1'].toString());

  return Bus.fromMap(train_response);
}