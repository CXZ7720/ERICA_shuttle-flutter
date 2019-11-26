import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'dart:core';

class Timetable {
  final String time;
  final String type;


  Timetable({this.time, this.type});

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      time: json['time'] as String,
      type: json['type'] as String,

    );
  }
}





Future<Timetable> fetchData(target) async {
  final response =
  await http.get('https://shuttle.jaram.net/$target');
  var now = new DateTime.now();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int hour = now.hour;
  int min = now.minute;
  int sec = now.second;


  if (response.statusCode == 200) {
//    print(json.decode(response.body)[0]);
    // If server returns an OK response, parse the JSON.
//    print(json.decode(response.body)[0]['time']);
    //function to make timetable list
    List<dynamic> buslist = json.decode(response.body);
    List<dynamic> result = [];
    for(var i = 0; i < buslist.length; i++){
      var temp =buslist[i]['time'].split(":");
      if(int.parse(temp[0]) * 60 + int.parse(temp[1]) - hour * 60 - min > 0){
//       var tmpstr = year.toString() + "-" + month.toString() + "-" + day.toString() + " " + temp[0] + ":" + temp[1] + ":" + sec.toString();
//        var tmpdate = (DateTime.parse(tmpstr.toString()).millisecond / 1000).round();
//        print(tmpstr);
//        result.add(temp[0] + ":" + temp[1]);
        result.add(buslist[i]);
        if(result.length > 4){
          break;
        }
      }
    }
    print(result[0]);
//    print(json.decode(result)[0]);
    print(json.decode(response.body));
//    return Timetable.fromJson(result)
    return Timetable.fromJson(result[0]);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
