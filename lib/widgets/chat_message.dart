import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final bool   status;

  const ChatMessage({
    Key key, 
    this.status = false,    
    @required this.text, 
    @required this.uid,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      child: this.uid == authService.user.uid
      ? _my( context )
      : _others( context ),
    );
  }

  Widget _my( BuildContext context ){

    // Valores para el manejo de las burbujas del chat
    double value = 0.2;
    if(this.text.trim().length > 9 ){value = 0.3;}
    if(this.text.trim().length > 14 ){value = 0.4;}
    if(this.text.trim().length > 19 ){value = 0.5;}
    if(this.text.trim().length > 24 ){value = 0.6;}
    if(this.text.trim().length > 29 ){value = 0.7;}    
    
     
    return ChatBubble(
      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
      backGroundColor: Colors.green[200],
      alignment: Alignment.centerRight,
      elevation: 1.5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * value,
        ),       
        child: Column(
          children: [
            Text(this.text, style: TextStyle(color: Colors.black),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("11:26", style: TextStyle(color: Colors.black54, fontSize: 12)),
                Icon( this.status ? Icons.done_all_outlined : Icons.done,size: 12.0,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _others( BuildContext context ){
    // Valores para el manejo de las burbujas del chat
    double value = 0.2;
    if(this.text.trim().length > 9 ){value = 0.3;}
    if(this.text.trim().length > 14 ){value = 0.4;}
    if(this.text.trim().length > 19 ){value = 0.5;}
    if(this.text.trim().length > 24 ){value = 0.6;}
    if(this.text.trim().length > 29 ){value = 0.7;}       

    return ChatBubble(
      clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
      backGroundColor: Colors.grey[200],
      alignment: Alignment.centerLeft,
      elevation: 1.5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: FittedBox(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * value,
          ),
          child: Column(
            children: [
              Text(this.text, style: TextStyle(color: Colors.black),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("11:26", style: TextStyle(color: Colors.black54, fontSize: 12)),
                  //Icon( this.status ? Icons.done_all_outlined : Icons.done,size: 12.0,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}