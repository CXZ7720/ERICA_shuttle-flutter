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

getSubwayData(target) async {
  // 현재는 파라미터에 상관없이 4호선을 고정출력하게 함.
  // @TODO : 추후에 수인선 개통시 파라미터에 따라 List 인덱스를 순회하여 가져오도록 하면 됨.(API 레퍼런스 참조)

  var key = await getTopisKey();
  Map<String, dynamic> parsedData = {
    "code": "",
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
      Map<String, dynamic> subwayList = json.decode(response.body);
//      print(subwayList);
//      print(subwayList['realtimeArrivalList'][0]['trainLineNm']);
      if (subwayList['errorMessage']['code'] == "INFO-000") {
        //정상운행중
        parsedData['code'] = subwayList['errorMessage']['code'];

        parsedData["upper_dest"] = subwayList['realtimeArrivalList'][0]['bstatnNm']; //당고개행
        parsedData["upper_trainLineNm"] =
            subwayList['realtimeArrivalList'][0]['trainLineNm']; //당고개행 - 상록수방면 : 둘 중에 하나 골라서 사용.
        parsedData["upper_current"] = subwayList['realtimeArrivalList'][0]['arvlMsg3']; //안산
        parsedData["upper_arvlMsg2"] = subwayList['realtimeArrivalList'][0]['arvlMsg2']; //[2]전역 안산

        parsedData["lower_dest"] = subwayList['realtimeArrivalList'][2]['bstatnNm']; //오이도행
        parsedData["lower_trainLineNm"] =
            subwayList['realtimeArrivalList'][2]['trainLineNm']; //오이도행 - 상록수방면 : 둘 중에 하나 골라서 사용.
        parsedData["lower_current"] = subwayList['realtimeArrivalList'][2]['arvlMsg3']; //상록수
        parsedData["lower_arvlMsg2"] = subwayList['realtimeArrivalList'][2]['arvlMsg2']; //[1]전역 상록수
      } else {
        parsedData['code'] = subwayList['errorMessage']['code'];
      }

    }

    return parsedData;
  } catch (e) {
    print("SUBWAY error occured!");
    print(e);
  }
}

class Subway {
  final String code;
  final String upper_dest;
  final String upper_trainLineNm;
  final String upper_current;
  final String upper_arvlMsg2;

  final String lower_dest;
  final String lower_trainLineNm;
  final String lower_current;
  final String lower_arvlMsg2;

  Subway({
    this.code,
    this.upper_dest,
    this.upper_trainLineNm,
    this.upper_current,
    this.upper_arvlMsg2,
    this.lower_dest,
    this.lower_trainLineNm,
    this.lower_current,
    this.lower_arvlMsg2,
  });

  factory Subway.fromMap(Map<String, dynamic> data) {
    return Subway(
      code: data['code'],
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

Future<Subway> querySubway(target) async {
  final Map train_response = await getSubwayData(target);

  return Subway.fromMap(train_response);
}
