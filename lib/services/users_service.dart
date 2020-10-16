

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/models/get_all_users_response.dart';
import 'package:messenger/models/user.dart';
import 'package:messenger/global/environments.dart';
import 'package:messenger/services/auth_service.dart';

class UsersService with ChangeNotifier {

  Future<List<User>> getAll() async {


    try{
      final resp = await http.get('${ Environments.apiUrl }users',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final apiResponse = getAllUsersResponseFromJson(resp.body);
      return apiResponse.users;
    }catch(e){
      return [];
    }
  }
}