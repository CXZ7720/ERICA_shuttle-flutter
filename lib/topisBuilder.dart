import 'package:flutter/material.dart';
import 'subway_query.dart';
import 'const.dart';

FutureBuilder<Subway> subwaybuilder(target) {
  //subway_4_upper, subway_4_lower 등 종류를 파라미터로 받음
  return FutureBuilder<Subway>(
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
                Row(
                  children: <Widget>[
                    if (snapshot.data.code == "INFO-200")
                      Text(
                        '운행중인 열차가 없습니다.',
                        style: kEndsubwayText,
                      ),
                    if (snapshot.data.code == "INFO-000")
                      Column(
                        children: <Widget>[
                          Text(
                            snapshot.data.trainLineNm,
                            style: ktypeText,
                          ),
                          Text(
                            snapshot.data.arvlMsg2,
                            style: ktypeText,
                          ),
                        ],
                      )
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
