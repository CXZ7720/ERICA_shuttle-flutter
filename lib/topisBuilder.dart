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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            snapshot.data.dest + "행",
                            style: kSubwayDestStyle,
                          ),
                          Text(
                            snapshot.data.arvlMsg2,
                            style: karvlMsgText,
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
        return Text(
          "앗!! 정보를 받아오는데\n실패했어요.\n화면을 당겨내려 \n새로고침 해주세요.",
          style: kapiErrorText,
          textAlign: TextAlign.center,
        );
      }
      return CircularProgressIndicator();
    },
  );
}
