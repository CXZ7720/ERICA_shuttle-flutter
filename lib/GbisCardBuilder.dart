import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'GBusBuilder.dart';
import 'bus_query.dart';
import 'const.dart';

class BUS_3102 extends StatelessWidget {
  const BUS_3102({
    Key key,
    @required this.bus_3102,
  }) : super(key: key);

  final Future<Bus> bus_3102;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      "3102",
                      style: k3102Text,
                    ),
                    Text(
                      " 강남행",
                      style: k3102DestText,
                    ),
                  ],
                ),
                Text(
                  "한양대 게스트하우스",
                  style: kGuesthouseText,
                )
              ],
            ),
          ),
          busbuilder(bus_3102),
        ],
      ),
    );
  }
}
