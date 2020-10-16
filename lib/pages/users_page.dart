import 'package:flutter/material.dart';
import 'package:messenger/models/user.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:messenger/services/chat_service.dart';
import 'package:messenger/services/socket_service.dart';
import 'package:messenger/services/users_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<User> users = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>( context );
    final socketService = Provider.of<SocketService>( context );
    final user = authService.user;

    

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text( user.username , style: TextStyle(color: Colors.black54),),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.menu),
            onPressed: (){
              socketService.disconnect();
              AuthService.closeSession(context);
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only( right: 10 ),
              child: Icon( Icons.offline_bolt, color: socketService.serverStatus == ServerStatus.Online ? Colors.green : Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUsers,
          child: listViewUsers()
        ),
      ),
    );
  }

  Container listViewUsers() {
    return Container(
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => _userListTile( users[i] ), 
          separatorBuilder: (_, i) => Divider(), 
          itemCount: users.length
        )
      );
  }

  ListTile _userListTile( User user ){ 
    final chatService = Provider.of<ChatService>( context );
    return ListTile(
            title: Text(user.username),
            subtitle: Text(user.email),
            leading: CircleAvatar(
              backgroundColor: Colors.black38,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
              ),
            ),
            onTap: () {
              chatService.to = user;
              Navigator.pushNamed(context, 'chat');
            },
          );
  }

  _loadUsers() async{
    final usersService = new UsersService();
    this.users = await usersService.getAll();
    //await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

}