import 'package:flutter/material.dart';

class CustomRaisedButtom extends StatelessWidget {
  final String textButtom;
  final Color color;
  final double elevation;
  final double hlelevation;
  final double height;
  final Function onPressed;

  const CustomRaisedButtom({
    Key key, 
    @required this.textButtom,
    @required this.onPressed, 
    this.color = Colors.grey,
    this.elevation = 2,
    this.hlelevation = 5,
    this.height = 55
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton( 
      elevation: this.elevation,
      color: this.color,
      highlightElevation: this.hlelevation,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: this.height,
        child: Center(
          child: Text(this.textButtom, style: TextStyle( color: Colors.white, fontSize: 16)),
        ),
      ),
      onPressed: this.onPressed
    );
  }
}