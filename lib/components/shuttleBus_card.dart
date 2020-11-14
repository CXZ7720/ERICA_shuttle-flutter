import 'package:HYBUS/FutureBuilder.dart';
import 'package:HYBUS/const.dart';
import 'package:HYBUS/reusable_card.dart';
import 'package:HYBUS/shuttle_query.dart';
import 'package:flutter/material.dart';

class ShuttleBusCard extends StatefulWidget {
  ShuttleBusCard({Key key, this.index, this.title, this.fetchedData}) : super(key: key);
  final int index;
  final String title;
  final Future<Timetable> fetchedData;
  @override
  _ShuttleBusCardState createState() => _ShuttleBusCardState();
}

class _ShuttleBusCardState extends State<ShuttleBusCard> {
  bool _animate = false;
  bool _isStart = true; // play animation first time - static
  bool _dispose = false;
  @override
  void initState() {
    super.initState();
    animationControll(80);
  }

  void animationControll(int speed) {
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * speed), () {
            {
              if(!_dispose)
              setState(() {
                _animate = true;
                _isStart = false;
              });
            }
          })
        : _animate = true;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;

  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding: _animate ? const EdgeInsets.all(0.0) : const EdgeInsets.only(top: 90),
        child: ReusableCard(
          color: Colors.white,
          height: (MediaQuery.of(context).size.height) * 0.17,
          cardChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.title, style: kDestinationText),
                  ],
                ),
              ),
              buildFutureBuilder(widget.fetchedData),
            ],
          ),
        ),
      ),
    );
  }
}
