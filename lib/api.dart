import 'package:http/http.dart' as http;
import 'dart:convert';

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
  await http.get('https://dev.jaram.net/$target');

  if (response.statusCode == 200) {
    print(json.decode(response.body)[0]);
    // If server returns an OK response, parse the JSON.
    return Timetable.fromJson(json.decode(response.body)[0]);
//    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//    return parsed.map<Timetable>((json) => Timetable.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
