import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.color, this.cardChild, this.height});

  final Color color;
  final Widget cardChild;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(3, 3)
          )
        ]
      ),
    );
  }
}
