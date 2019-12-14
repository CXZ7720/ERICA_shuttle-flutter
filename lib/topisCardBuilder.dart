import 'package:flutter/material.dart';
import 'package:shuttlecock_flutter/topisBuilder.dart';
import 'reusable_card.dart';
import 'subway_query.dart';
import 'const.dart';

class SUBWAY_4 extends StatelessWidget {
  const SUBWAY_4({
    Key key,
    @required this.subway_4,
  }) : super(key: key);

  final Future<Subway> subway_4;
//  final Future<Subway> subway_4_upper;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: Colors.white,
      height: (MediaQuery.of(context).size.height) * 0.15,
      width: MediaQuery.of(context).size.width,
      cardChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "4호선",
                  style: k3102Text,
                ),
              ],
            ),
          ),
          subwaybuilder(subway_4)//UP/DOWN
        ],
      ),
    );
  }
}
