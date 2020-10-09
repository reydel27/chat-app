import 'package:flutter/material.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot ){
          return Center(
            child: Text('Loading ...'),
          );
        }, 
      ),
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);

    final userAuthenticated = await authService.isLoggedIn();

    if( userAuthenticated ){
      Navigator.pushReplacementNamed(context, 'users');
    }else{
      Navigator.pushReplacementNamed(context, 'signin');
    }

  }
}