import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/models/get_all_messages_response.dart';
import 'package:messenger/models/user.dart';
import 'package:messenger/global/environments.dart';
import 'package:messenger/services/auth_service.dart';

class ChatService with ChangeNotifier { 

  User to;

  Future<List<Message>> getChat( String userId) async {
    try{
    final resp = await http.get('${ Environments.apiUrl }messages/$userId',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
    );
    final apiResponse = getAllMessagesResponseFromJson(resp.body);
    return apiResponse.messages;
    }catch(e){
      return [];
    }
  }
}