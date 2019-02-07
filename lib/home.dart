import 'package:flutter/material.dart';
import 'package:flutter_progress_button_animation/progress_button.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Progress Button Animation App"),
        ),
        body: new Center(
            child: new ProgressButton(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Click...',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    ]),
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(1.0),
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]),
                onPressed: () {
                  print('button clicked');
                })));
  }
}
