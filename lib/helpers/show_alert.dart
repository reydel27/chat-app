import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert( BuildContext context, String title, String content ){


  if( Platform.isAndroid ){
    return showDialog(
      context: context,
      builder: ( _ ) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ) 
    );
  }

  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text( title ),
      content: Text( content ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],      
    )
  );
}