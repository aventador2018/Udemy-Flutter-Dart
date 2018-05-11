import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {

  List _data = await getJson();

  String _body = "";

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "JSON Parse"
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return new Divider();

            final index = position ~/2;

            return new ListTile(
              title: new Image.network("${_data[index]['url']}"),
              subtitle: new Text(
                "${_data[index]['title']}",
                style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0
                ),
              ),
              leading: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Image.network("${_data[index]['thumbnailUrl']}")
              ),
              onTap: () {_showOnTapMessage(context, "${_data[index]['title']}");},
            );
          },
        )
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed: () {Navigator.pop(context);}, child: new Text('OK'))
    ],
  );
//  showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/photos';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}