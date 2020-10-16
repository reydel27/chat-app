import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:messenger/routes/routes.dart';

import 'package:messenger/services/auth_service.dart';
import 'package:messenger/services/chat_service.dart';
import 'package:messenger/services/socket_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ( _ ) => AuthService()),
            ChangeNotifierProvider(create: ( _ ) => ChatService()),
            ChangeNotifierProvider(create: ( _ ) => SocketService()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'byS Messenger',
            initialRoute: 'loading',
            routes: appRoutes,
      ),
    );
  }
}