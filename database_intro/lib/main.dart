import 'package:database_intro/models/user.dart';
import 'package:database_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';




List _users;

void main() async {

  var db = new DatabaseHelper();

  //Add user
  //int savedUser = await db.saveUser(new User("Bond", "james"));

  //print("User saved $savedUser");

  //Get all users;
  _users = await db.getAllUsers();
  for(int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);

    print("Username: ${user.username}");
  }

  int _userCount = await db.getCount();
  print("Count: $_userCount");


  runApp(new MaterialApp(
    title: 'database',
    home: new Home(),
  ));
}


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Database"
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: new ListView.builder(
        itemCount: _users.length,
        itemBuilder: (_, int position) {
          return new Card(
            color: Colors.white,
            elevation: 2.0,
            child: new ListTile(
              leading: new CircleAvatar(
                child: new Text("${User.fromMap(_users[position]).id}"),
              ),
              title: new Text("User ${User.fromMap(_users[position]).username}"),
              subtitle: new Text("Id: ${User.fromMap(_users[position]).password}"),
            ),
          );
        },
      )
    );
  }
}
