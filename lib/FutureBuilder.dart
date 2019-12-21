import 'package:flutter/material.dart';
import 'shuttle_query.dart';
import 'const.dart';

FutureBuilder<Timetable> buildFutureBuilder(target) {
  return FutureBuilder<Timetable>(
    future: target,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data.isSpecial);
        List Timearr = snapshot.data.time.split(":");
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (snapshot.data.isSpecial != null)
                  Text(
                    //첫차 막차 표시부분
                    "[" + snapshot.data.isSpecial + "]",
                    style: kSpecialBustype,
                    textAlign: TextAlign.left,
                  ),
                if (snapshot.data.time != "운행종료")
                  Text(
                    snapshot.data.type,
                    style: ktypeText,
                  ),
              ],
            ),
            SizedBox(
              width: 7.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
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
            ),

          ],
        );
      } else if (snapshot.hasError) {
        print(snapshot.error);
        return Text("${snapshot.error}");
      }
      return SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
        height: 20.0,
        width: 20.0,
      );
    },
  );
}
