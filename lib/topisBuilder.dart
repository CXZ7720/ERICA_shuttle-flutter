import 'package:flutter/material.dart';
import 'subway_query.dart';
import 'const.dart';

FutureBuilder<Subway> subwaybuilder(target) {
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
                    if (snapshot.data.code == "")
                      Text(
                        '운행중인 열차가 없습니다.',
                        style: ktypeText,
                      ),
                    if (snapshot.data.code == "INFO-000")
                      Column(
                        children: <Widget>[
                          Text(
                            snapshot.data.lower_trainLineNm,
                            style: ktypeText,
                          ),
                          Text(
                            snapshot.data.lower_arvlMsg2,
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
