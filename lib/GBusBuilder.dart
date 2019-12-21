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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    if (snapshot.data.resultCode == 4)
                      Text(
                        '차고지 대기중',
                        style: kSpecialBustype,
                      ),
                    if (snapshot.data.resultCode.toString() == "0")
                      Row(
                        children: <Widget>[
                          Text(
                            snapshot.data.locationNo1.toString(),
                            style: kLocationText,
                          ),
                          Text(
                            " 번째 전",
                            style: kWillArriveText,
                          ),
                        ],
                      ),
                    if (snapshot.data.resultCode.toString() == "0")
                      Row(
                        children: <Widget>[
                          Text(
                            snapshot.data.predictTime1.toString(),
                            style: kPredictTime1,
                          ),
                          Text(
                            " 분 후 도착예정",
                            style: kWillArriveText,
                          ),
                        ],
                      ),
                  ],
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
