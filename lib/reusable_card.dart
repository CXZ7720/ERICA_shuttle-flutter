import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.color, this.cardChild, this.height, this.width});

  final Color color;
  final Widget cardChild;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: cardChild,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color(0xffe4e4f0),//black12
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(3, 3))
          ]),
    );
  }
}
