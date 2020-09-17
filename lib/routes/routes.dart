

import 'package:flutter/material.dart';

import 'package:messenger/pages/chat_page.dart';
import 'package:messenger/pages/loading_page.dart';
import 'package:messenger/pages/signin_page.dart';
import 'package:messenger/pages/signup_page.dart';
import 'package:messenger/pages/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users'  : ( _ ) => UsersPage(),
  'chat'   : ( _ ) => ChatPage(),
  'signin' : ( _ ) => SigninPage(),
  'signup' : ( _ ) => SignupPage(),
  'loading': ( _ ) => LoadingPage()
};