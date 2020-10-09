

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/global/environments.dart';
import 'package:messenger/models/signin_response.dart';
import 'package:messenger/models/user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {

  User user;
  bool _signing = false;

  final _storage = new FlutterSecureStorage();

  bool get signing => this._signing;
  set signing( bool value ){
    this._signing = value;
    notifyListeners();
  }
 // Metodos estaticos para gestionar el token desde cualquier parte
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  static Future<void> closeSession( BuildContext context ) async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token'); 
    Navigator.pushReplacementNamed(context, 'signin');   
  }

  Future<bool> signin( String email, String password ) async {

    this.signing = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${Environments.apiUrl}auth/signin',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );


    print( resp.body );
    this.signing = false;

    if( resp.statusCode == 200 ){
      final signinResponse =  signinResponseFromJson( resp.body );
      this.user = signinResponse.user;
      await this._saveToken(signinResponse.token);
      //print('token storage:' + await getToken()); probar el token
      return true;
    }else{

      return false;
    }
  } 

  Future<bool> signup( String username, String email, String password, String host) async {

    this.signing = true;

    final data = {
      'host': host,
      'email': email,
      'password': password,
      'username': username,      
    };

    final resp = await http.post('${Environments.apiUrl}auth/signup',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );


    print( resp.body );
    this.signing = false;

    if( resp.statusCode == 200 ){
      final signinResponse =  signinResponseFromJson( resp.body );
      this.user = signinResponse.user;
      await this._saveToken(signinResponse.token);
      return true;
    }else{

      return false;
    }
  } 


  Future validate( String code ) async {

    this.signing = true;

    final data = {
      'code': code
    };

    final resp = await http.post('${Environments.apiUrl}auth/guess',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.signing = false;
    //print(resp.body);
    final response = jsonDecode(resp.body);
    return response;
  } 

  Future<bool>isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    
    final resp = await http.get('${Environments.apiUrl}auth/refresh-token',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }          
    );

    if( resp.statusCode == 200 ){
      final response = jsonDecode(resp.body);
      await this._saveToken(response['token']);
      return true;
    }else{
      this.logout();
      return false;
    }    
  }
  Future _saveToken( String token ) async {
    return await _storage.write(key: 'token', value: token );
  }
  Future logout() async {
    await _storage.delete(key: 'token');
  }
} 