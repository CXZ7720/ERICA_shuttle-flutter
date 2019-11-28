import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Timetable {
  final String time;
  final String type;


  Timetable({this.time, this.type});

  // ignore: missing_return
  factory Timetable.fromJson(Map<String, dynamic> json) {

    if(json['type'] == "C"){
      json['type'] = "순환노선";
    } else if(json['type'] == "DY") {
      json['type'] = "예술인행";
    } else if (json['type'] == "DH") {
      json['type'] = "한대앞행";
    } else if (json['type'] == "NA") {
      json['type'] = "운행안함";
    } else {
      json['type'] = "셔틀콕행";
    }


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

  int hour = now.hour;
  int min = now.minute;

  if (response.statusCode == 200) {
    List<dynamic> buslist = json.decode(response.body);
    List<dynamic> result = [];
    for(var i = 0; i < buslist.length; i++){
      var temp =buslist[i]['time'].split(":");
      if(int.parse(temp[0]) * 60 + int.parse(temp[1]) - hour * 60 - min > 0){

        result.add(buslist[i]);
        if(result.length > 4){ //일단은 4개 넣어둠.
          break;
        }
      }
    }
//    print(result[0]);
//    print(json.decode(result)[0]);
//    print(json.decode(response.body));
//    return Timetable.fromJson(result)
    return Timetable.fromJson(result[0]);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
