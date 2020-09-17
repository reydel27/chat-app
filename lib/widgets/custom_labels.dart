import 'package:flutter/material.dart';

class CustomLabels extends StatelessWidget {

  final String mainText;
  final String buttonText;
  final String to;

  const CustomLabels({
    @required this.mainText, 
    @required this.buttonText,
    this.to
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.mainText, style: TextStyle( color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.w300),),
          SizedBox( height: 7.5 ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.to);
            },
            child: Text(this.buttonText, style: TextStyle( color: Colors.blue[600], fontSize: 15, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}