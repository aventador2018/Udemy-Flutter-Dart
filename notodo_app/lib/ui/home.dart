import 'package:flutter/material.dart';

import 'notodo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("NoToDo"),
        backgroundColor: Colors.black54,
      ),
      body: new NotoDoScreen(),
    );
  }
}
