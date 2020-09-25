

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/models/user.dart';
import 'package:messenger/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final user = User(
    uid: '1',
    name: 'Rey',
    status: 'ETC como metes un elefante por una puerta',
    online: true
  );

  List<ChatMessage> _messages = [];

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();


  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: null,
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: user.online ? Colors.green[300] : Colors.red,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: TextStyle( color: Colors.black54, fontSize: 16),),
                    Text( _isWriting ? 'is writing ...' : '', style: TextStyle( color: Colors.black54, fontSize: 12),)
                  ],
                ),
              )
            ],
          ),
          actions: [
            IconButton(icon: Icon(Icons.videocam_outlined), onPressed: null)
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) => _messages[i],
                )                  
              ),
              Divider(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.add)
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric( horizontal: 8, vertical: 4 ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black45
                          )
                        ),
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (_){},
                          onChanged: ( text ){
                            setState((){
                              if( text.trim().length > 0 ){
                                _isWriting = true;
                              }else{
                                _isWriting = false;
                              }
                            });
                          },
                          decoration: InputDecoration.collapsed(hintText: 'New Message'),
                          focusNode: _focusNode,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric( horizontal: 4),
                      child: _isWriting ? IconButton(
                        icon: Icon(Icons.send_rounded, color: Colors.blue,),
                        onPressed: _isWriting ? () => _handleSubmit( _textController.text.trim() ) : null,
                      ): Row(
                        children: [
                          IconButton(
                            color: Colors.black45,
                            icon: Icon(Icons.camera_alt_outlined),
                            onPressed: (){},
                          ),
                          IconButton(
                            color: Colors.black45,
                            icon: Icon(Icons.mic_outlined),
                            onPressed: (){},
                          ),                          
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  _handleSubmit( String text ){

    if(text.length == 0) return;
    
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '1',
      text: text,
    );
    _messages.insert(0, newMessage);
    setState((){
      _isWriting = false;
    });

    @override
    void dispose(){
      //TODO: Off del socket

      
      super.dispose();
    }
  }
}