import 'package:flutter/material.dart';
import 'api.dart';
import 'const.dart';

FutureBuilder<Timetable> buildFutureBuilder(target) {


  return FutureBuilder<Timetable>(
    future: target,
    builder: (context, snapshot) {


      if (snapshot.hasData) {
        return Row(
          children: <Widget>[
            Text(snapshot.data.type, style: ktypeText,),
            Text(
              snapshot.data.time,
              style: kTimeText,
            ),
            Text(' 도착예정'),
          ],
        );
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
    },
  );
}
