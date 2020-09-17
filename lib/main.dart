import 'package:flutter/material.dart';
import 'package:messenger/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'byS Messenger',
      initialRoute: 'signin',
      routes: appRoutes,
    );
  }
}