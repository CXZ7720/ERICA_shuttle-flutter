import 'package:flutter/material.dart';
import 'api.dart';
import 'const.dart';

FutureBuilder<Timetable> buildFutureBuilder(target) {
  return FutureBuilder<Timetable>(
    future: target,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data.isSpecial);
        List Timearr = snapshot.data.time.split(":");
        return Row(
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            if (snapshot.data.time != "운행종료")
              Text(
                snapshot.data.type,
                style: ktypeText,
              ),
            if (snapshot.data.isSpecial != null)
              Text(
                "[" + snapshot.data.isSpecial + "]",
                style: kSpecialBustype,
              ),
            Text(
              Timearr[0] + "시" + Timearr[1] + "분",
              style: kTimeText,
            ),
            if (snapshot.data.time != "운행종료")
              Text(
                ' 도착예정',
                style: kWillArriveText,
              ),
          ],
        );
      } else if (snapshot.hasError) {
        print(snapshot.error);
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
    },
  );
}
