import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

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
  final response =
  await http.get('https://hyu-shuttlebus.appspot.com/$target');
  var now = new DateTime.now();

  int hour = now.hour;
  int min = now.minute;
//  int hour = 23;
//  int min = 13;
  List<dynamic> result = [];

  if (response.statusCode == 200) {
    List<dynamic> buslist = json.decode(response.body);
    for(var i = 0; i < buslist.length; i++){
      var temp =buslist[i]['time'].split(":");
      if(int.parse(temp[0]) * 60 + int.parse(temp[1]) - hour * 60 - min > 0){

        result.add(buslist[i]);
        if(result.length > 4){ //일단은 4개 넣어둠.
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
      result.add(json.decode(response.body)[0]); // 첫차 삽입.

    }

    if(result[0]['time'] == json.decode(response.body)[0]['time']) {
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
