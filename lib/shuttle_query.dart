import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart' show rootBundle;
import 'utils.dart';

class Timetable {
  final String time;
  final String type;
  final String isSpecial;


  Timetable({this.time, this.type, this.isSpecial});

  // ignore: missing_return
  factory Timetable.fromJson(Map<String, dynamic> json) {

    if(json['type'] == "C"){
      json['type'] = "순환노선";
    } else if(json['type'] == "DY") {
      json['type'] = "예술인행";
    } else if (json['type'] == "DH") {
      json['type'] = "한대앞행";
    } else if (json['type'] == "NA") {
      json['type'] = "기숙사행";
    } else {
      json['type'] = "셔틀콕행";
    }

    switch(json['isSpecial']) {
      case "F":{ // 첫차 - First
        json['isSpecial'] = '첫차';
       }
       break;

      case "L":{ // 첫차 - First
        json['isSpecial'] = '막차';
      }
      break;
    }


//print("PASS");
    return Timetable(
      time: json['time'] as String,
      type: json['type'] as String,
      isSpecial: json['isSpecial'] as String
    );
  }
}





Future<Timetable> fetchData(target) async {
  final settings = await rootBundle.loadString('lib/settings.json');

  Map<String, dynamic> decoded_settings = json.decode(settings.toString());
  String datekind = getDateKind(decoded_settings); //semester, vacation, vacation_session
  String daykind = getDaykind(decoded_settings); //week, weekend
  print("날짜 구분 : $daykind");
  print("학기 구분 : $datekind");
  String filename = '';
  switch (target) {
    case 'shuttlecock_i':
      filename = "Shuttlecock_I_$daykind.json";
      break;
    case 'shuttlecock_o':
      filename = "Shuttlecock_O_$daykind.json";
      break;
    case 'giksa':
      filename = "Residence_$daykind.json";
      break;
    case 'subway':
      filename = "Subway_$daykind.json";
      break;
    case 'yesulin':
      filename = "YesulIn_$daykind.json";
      break;
    default:
      filename = "";
  }



  final response =
  await http.get('https://storage.googleapis.com/hybus-timetable/timetable/$datekind/$daykind/$filename');

  var now = new DateTime.now();
  int hour = now.hour;
  int min = now.minute;
//  int hour = 23;
//  int min = 13;
  List<dynamic> result = [];
  var objIdx = filename.split(".")[0].toLowerCase();
  if (response.statusCode == 200) {
    Map<dynamic, dynamic> tempRes = json.decode(response.body);
    List<dynamic> buslist = tempRes[objIdx];

    for(var i = 0; i < buslist.length; i++){
      var temp =  buslist[i]['time'].split(":");

      if(int.parse(temp[0]) * 60 + int.parse(temp[1]) - hour * 60 - min > 0){

        result.add(buslist[i]);
        if(result.length > 2){ //일단은 2개 넣어둠.
          break;
        }
      }
    }

//막차 && 첫차 파라미터 추가 부분
    if(result.length == 1 ) {
      result[0]['isSpecial'] = "L"; // 막차인경우 막차 파라미터 추가(Last)
    }

//    알고리즘으로 계산된 결과값이 빈 값을 리턴할때 : 23:30 ~ 00:00 사이 시간대
    if (result.length == 0){
//      result.add({"time" : "운행종료", "type": ""});
    print("첫차 삽입됨");
      result.add(buslist[0]); // 첫차 삽입.

    }

    if(result[0]['time'] == buslist[0]['time']) {
      result[0]['isSpecial'] = "F"; //첫차를 표시해야 할 경우 첫차 파라미터 추가(First)
    }
//    막차첫차 파라미터 추가 끝



//    print("res = " + result[0]);
//    print(json.decode(result)[0]);

//    print(result);
//    return Timetable.fromJson(result)
    return Timetable.fromJson(result[0]);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
