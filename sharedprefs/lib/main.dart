import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    title: 'SharedPrefs',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  String _savedData = "";

  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data') != null && preferences.getString('data').isNotEmpty ) {
        _savedData = preferences.getString("data");
      }else {
        _savedData = "Empty SP";

      }

    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); // key : value ==> "paulo" : "Smart"


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shared Prefs'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterDataField,
            decoration: new InputDecoration(labelText: 'Write Something'),
          ),
          subtitle: new FlatButton(
              color: Colors.redAccent,
              onPressed: () {
                _saveMessage(_enterDataField.text);
              },
              child: new Column(
                children: <Widget>[
                  new Text('Save Data'),
                  new Padding(padding: new EdgeInsets.all(14.5)),
                  new Text(_savedData),
                ],
              )),
        ),
      ),
    );
  }
}
