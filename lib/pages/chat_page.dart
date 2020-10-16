

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/models/get_all_messages_response.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:messenger/services/chat_service.dart';
import 'package:messenger/services/socket_service.dart';
import 'package:messenger/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatMessage> _messages = [];

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  @override
  void initState() { 
    
    super.initState();
    this.chatService   = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);  

    this.socketService.socket.on('private-message', _listenMessage); 
    this.socketService.socket.on('writing', _listenIsWriting); 
  
    _loadDbMessages( this.chatService.to.uid );
  }

  void _loadDbMessages( String userId ) async {
    List<Message> chat = await this.chatService.getChat(userId);
    
    final onDb = chat.map((m) => new ChatMessage(
      text: m.message, 
      uid : m.from)
    );

    setState(() {
      _messages.insertAll(0, onDb);
    });
  }


  void _listenIsWriting( dynamic payload ){
    setState(() {
      _isWriting = payload['writing'];      
    });
  }
  // ---------------------------------------------- 

  // ---------------------------------------------- 
  void _listenMessage( dynamic payload){
    //print('Have message $data');
    ChatMessage message = ChatMessage(
      text: payload['message'], 
      uid : payload['from']
    );

    setState(() {
      _messages.insert(0, message);
    });
  }    
  bool _isWriting = false;
  bool _imWriting = false;

  @override
  Widget build(BuildContext context) {

    final user = chatService.to;
    /*
    if( user.online != _isOnline ){
      user.online = _isOnline;
    }  
    */ 
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
                    Text(user.username, style: TextStyle( color: Colors.black54, fontSize: 16),),
                    Text( _isWriting ? 'is writing ...' : user.online ? 'online' : '' , style: TextStyle( color: Colors.black54, fontSize: 12),)
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
                                _imWriting = true;
                              }else{
                                _imWriting = false;
                              }
                              this.socketService.emit('writing',{
                                'from'   : this.authService.user.uid,
                                'to'     : this.chatService.to.uid,
                                'writing': _imWriting      
                              });                              
                            });
                          },
                          decoration: InputDecoration.collapsed(hintText: 'New Message'),
                          focusNode: _focusNode,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric( horizontal: 4),
                      child: _imWriting ? IconButton(
                        icon: Icon(Icons.send_rounded, color: Colors.blue,),
                        onPressed: _imWriting ? () => _handleSubmit( _textController.text.trim() ) : null,
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
      uid: authService.user.uid,
      text: text,
    );
    _messages.insert(0, newMessage);
    setState((){_imWriting = false;});

    this.socketService.emit('private-message',{
      'from'   : this.authService.user.uid,
      'to'     : this.chatService.to.uid,
      'message': text
    });
  }

  @override
  void dispose(){
    this.socketService.socket.off('private-message');
    this.socketService.socket.off('writing');
    super.dispose();
  }  
}