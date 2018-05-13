import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() async {

  Map _data = await getJson();

  List _features = _data['features'];

  var format = new DateFormat.yMMMMd("en_US").add_jm();

  print(_features);

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text(
            "Quakes"
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: new Center(
          child: new ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();

              final index = position ~/2;

              return new ListTile(
                title: new Text("${format.format(DateTime.fromMillisecondsSinceEpoch(_features[index]['properties']['time']))}"),
                subtitle: new Text(
                  "${_features[index]['properties']['place']}",
                  style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    fontStyle: FontStyle.italic
                  ),
                ),
                leading: new CircleAvatar(
                    backgroundColor: Colors.green,
                    child: new Text(
                        "${_features[index]['properties']['mag']}"
                    )
                ),
                onTap: () {_showOnTapMessage(context, "${_features[index]['properties']['title']}", "${_features[index]['properties']['type']}");},
              );
            },
          )
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message, String type) {
  var alert = new AlertDialog(
    title: new Text(type),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(onPressed: () {Navigator.pop(context);}, child: new Text('OK'))
    ],
  );
//  showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<Map> getJson() async {
  String apiUrl = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}