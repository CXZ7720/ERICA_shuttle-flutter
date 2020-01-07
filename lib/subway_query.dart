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
    "code": "INFO-200",
    "dest": "", // 하행선 종착역
    "trainLineNm": "", //하행선 열차종류("오이도행 - 중앙방면")
    "current": "", //하행선 현위치
    "arvlMsg2": "", //하행선 도착메세지([1]전역 상록수)
  };
//  final Xml2Json trans = Xml2Json();
//  print(key);
  try {
    var url = 'http://swopenapi.seoul.go.kr/api/subway/' +
        key.toString() +
        '/json/realtimeStationArrival/0/5/%ED%95%9C%EB%8C%80%EC%95%9E';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
//      print(response.body.toString());
      Map<String, dynamic> subwayList = json.decode(response.body);
//      print(subwayList['status']);

      if (subwayList['status'] == 500 && subwayList['code'] == "INFO-200") {
        //운행종료
        parsedData['code'] = subwayList['code'];
        return parsedData;
      }

      //1. 상하행 모두 정상운행 : 상하상하
      //2. 상행막차 하행남음 : 상하하
      //3. 상행종료 하행남음 : 하(하)
      //4. 상행정상 하행막차 : 상하상
      //5. 상행정상 하행종료 : 상(상)
      //6. 상행막차 하행막차 : 상하


      int idxnum = 0; //하행선 인덱스 파라미터

      if(subwayList['errorMessage']['total'] == 4) { //정상운행
        idxnum = 2;
      } else if (subwayList['errorMessage']['total'] == 3){ //상하하, 상하상 모두 포함. ''상상하'는 있을 수 없음.
        idxnum = 1;
      } else if (subwayList['errorMessage']['total'] == 2){ //상하 , 상상, 하하 인 경우
        if(subwayList['realtimeArrivalList'][0]['updnLine'] == '하행'){ //하하, 하
          idxnum = 0;
        } else if (subwayList['realtimeArrivalList'][1]['updnLine'] == '상행'){ //상상
          subwayList['errorMessage']['code'] = "INFO-200"; //상상인 경우에는 return 운행종료
        } else {//상하
          idxnum = 1;
        }
      } else if (subwayList['errorMessage']['total'] == 1){//상, 하
        if(subwayList['realtimeArrivalList'][0]['updnLine'] == '상행'){
          idxnum = 1;
        }
      } else {
        return parsedData;
      }


//      if (subwayList['errorMessage']['total'] == 2) {
//        //데이터 길이가 2일경우(막차 시간대)
//        idxnum = 1;
//      } else if (subwayList['errorMessage']['total'] == 1) {
//        //데이터 길이가 1일경우(막차 시간대)-parsedData 바로 리턴 : 기본값이 INFO-200 운행종료.
//        return parsedData;
//      }

      //열차가 종료하지 않았다면
//        print("ENTER NOMAL");
      if (subwayList['errorMessage']['code'] == "INFO-000") {
//        print("INFO CODE : 000");
        //정상운행중
        parsedData['code'] = subwayList['errorMessage']['code'];
//          print(target.toString() + "!!!!");
        if (target == "subway_4_upper") {
          //4호선 상행
          parsedData["dest"] =
              subwayList['realtimeArrivalList'][0]['bstatnNm']; //오이도행
          parsedData["trainLineNm"] = subwayList['realtimeArrivalList'][0]
              ['trainLineNm']; //오이도행 - 상록수방면 : 둘 중에 하나 골라서 사용.
          parsedData["current"] =
              subwayList['realtimeArrivalList'][0]['arvlMsg3']; //상록수
          if (subwayList['realtimeArrivalList'][0]['arvlMsg3'] == "한대앞" ||
              subwayList['realtimeArrivalList'][0]['arvlMsg3'] == "중앙") {
            //전역도착, 한대앞 도착, 한대앞 진입, 전역 진입 의 경우에는 그냥 출력
            parsedData["arvlMsg2"] =
                subwayList['realtimeArrivalList'][0]['arvlMsg2']; //[1]전역 상록수
          } else {
            //그밖의 경우에는 [3]번째 전역 (초지)형식을 다듬어서 리턴.
            parsedData["arvlMsg2"] = parseString(
                subwayList['realtimeArrivalList'][0]['arvlMsg2'],
                subwayList['realtimeArrivalList'][0]['arvlMsg3']);
          }
        }

        if (target == "subway_4_lower") {
          //4호선 하행
          parsedData["dest"] =
              subwayList['realtimeArrivalList'][idxnum]['bstatnNm']; //오이도행
          parsedData["trainLineNm"] = subwayList['realtimeArrivalList'][idxnum]
              ['trainLineNm']; //오이도행 - 상록수방면 : 둘 중에 하나 골라서 사용.
          parsedData["current"] =
              subwayList['realtimeArrivalList'][idxnum]['arvlMsg3']; //상록수
          if (subwayList['realtimeArrivalList'][idxnum]['arvlMsg3'] == "한대앞" ||
              subwayList['realtimeArrivalList'][idxnum]['arvlMsg3'] == "상록수") {
            //전역도착, 한대앞 도착, 한대앞 진입, 전역 진입 의 경우에는 그냥 출력
            parsedData["arvlMsg2"] = subwayList['realtimeArrivalList'][idxnum]
                ['arvlMsg2']; //[1]전역 상록수
          } else {
            //그밖의 경우에는 [3]번째 전역 (초지)형식을 다듬어서 리턴.
            parsedData["arvlMsg2"] = parseString(
                subwayList['realtimeArrivalList'][idxnum]['arvlMsg2'],
                subwayList['realtimeArrivalList'][idxnum]['arvlMsg3']);
          }
        }
      } else {
        print("return Code check please");
      }
    }

    return parsedData;
  } catch (e) {
    print("SUBWAY error occured!");
    print(e);
  }
}

parseString(arvlMsg2, arvlMsg3) {
  //arrvlMsg2 = [3]번째 전역 (초지), arvlMsg2 = 초지 형식.
  final String beforeN = arvlMsg2[1];

  final String modStr = beforeN + "역전 : " + arvlMsg3;
  return modStr;
}

class Subway {
  final String code;
//  final String upper_dest;
//  final String upper_trainLineNm;
//  final String upper_current;
//  final String upper_arvlMsg2;

  final String dest;
  final String trainLineNm;
  final String current;
  final String arvlMsg2;

  Subway({
    this.code,
//    this.upper_dest,
//    this.upper_trainLineNm,
//    this.upper_current,
//    this.upper_arvlMsg2,
    this.dest,
    this.trainLineNm,
    this.current,
    this.arvlMsg2,
  });

  factory Subway.fromMap(Map<String, dynamic> data) {
    return Subway(
      code: data['code'],
//      upper_dest: data['upper_dest'],
//      upper_trainLineNm: data['upper_trainLineNm'],
//      upper_current: data['upper_current'],
//      upper_arvlMsg2: data['upper_arvlMsg2'],
      dest: data['dest'],
      trainLineNm: data['trainLineNm'],
      current: data['current'],
      arvlMsg2: data['arvlMsg2'],
    );
  }
}

Future<Subway> querySubway(target) async {
  final Map train_response = await getSubwayData(target);

  return Subway.fromMap(train_response);
}
