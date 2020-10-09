import 'package:flutter/material.dart';
import 'package:messenger/models/user.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:provider/provider.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final users = [
    User(uid: '1', status: 'ETC como metes un elefante por  una puerta', username: 'Rey', online: false),
    User(uid: '2', status: 'Disponible', username: 'Laia', online: true),
    User(uid: '3', status: 'Ocupado', username: 'Marta', online: true),
    User(uid: '4', status: 'En el trabajo', username: 'Nino', online: true),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

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
              AuthService.closeSession(context);
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only( right: 10 ),
              child: Icon( Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: Container(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, i) => _userListTile( users[i] ), 
            separatorBuilder: (_, i) => Divider(), 
            itemCount: users.length
          )
        ),
      ),
    );
  }

  ListTile _userListTile( User user ) {
    return ListTile(
            title: Text(user.username),
            subtitle: Text(user.status),
            leading: CircleAvatar(
              backgroundColor: user.online ? Colors.green[300] : Colors.red,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
              ),
            ),
            /*
            trailing: Container(
              padding: EdgeInsets.only( right: 5, top: 5 ),
              child: Column(
                children: [
                  Text('10:22'),
                  Badge(
                    badgeColor: Colors.blue[300],
                    badgeContent: Text('3', style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
            */
          );
  }
}