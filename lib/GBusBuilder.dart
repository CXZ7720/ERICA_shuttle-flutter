import 'package:flutter/material.dart';
import 'bus_query.dart';
import 'const.dart';

FutureBuilder<Bus> busbuilder(target) {
  return FutureBuilder<Bus>(
    future: target,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Row(
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (snapshot.data.resultCode == 4)
                  Text(
                    '운행중인 버스가 없습니다.',
                    style: ktypeText,
                  ),
                if (snapshot.data.resultCode == 00)
                  Text(
                    snapshot.data.predictTime1.toString(),
                    style: ktypeText,
                  ),
              ],
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
