import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BMIState();
  }
}

class BMIState extends State<BMI> {

  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _height = new TextEditingController();
  final TextEditingController _weight = new TextEditingController();

  double _bmiScore = 0.0;
  String _situation = "";

  double calculateBMI() {
    setState(() {
      _bmiScore = (double.parse(_weight.text)/(double.parse(_height.text)*double.parse(_height.text)))*4.882;
      if(_bmiScore <= 18.5) {
        _situation = "Underweight";
      } else if (_bmiScore >18.5 && _bmiScore <= 24.9) {
        _situation = "Normal";
      } else if (_bmiScore > 24.9 && _bmiScore <= 29.9) {
        _situation = "Overweight";
      } else _situation = "Obese";
      return _bmiScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "BMI"
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: new ListView(
        children: <Widget>[
          new Image.asset("images/bmilogo.png", height: 230.0,),
          new Container(
            height: 200.0,
            decoration: new BoxDecoration(color: Colors.grey),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Age",
                    icon: new Icon(Icons.person),
                  ),
                ),
                new TextField(
                  controller: _height,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: "Height in feet",
                    icon: new Icon(Icons.assessment)
                  ),
                ),
                new TextField(
                  controller: _weight,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      hintText: "Weight in pounds",
                      icon: new Icon(Icons.line_weight)
                  )
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new RaisedButton(
                  color: Colors.pinkAccent,
                  onPressed: calculateBMI,
                  child: new Text("Calculate", style: new TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
          new Text(
            "Your BMI: ${_bmiScore.toStringAsFixed(1)}",
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          new Text(
            "$_situation",
            style: new TextStyle(
              color: Colors.pinkAccent,
              fontSize: 25.0,
              fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}