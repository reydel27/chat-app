import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {

  final String textLogo;
  final AssetImage imgLogo;

  const CustomLogo({
    @required this.imgLogo,
    @required this.textLogo
  });

  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        width: 170,
        child: Column(
          children: [
            Image(image: this.imgLogo),
            SizedBox( height: 20 ),
            Text(this.textLogo, style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );    
  }
}