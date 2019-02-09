import 'package:flutter/material.dart';
import 'package:flutter_progress_button_animation/phase_animation.dart';
import 'package:flutter_progress_button_animation/progress_button.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<Home> {
  String buttonText = "SYNC";
  PhaseAnimation phaseOne;
  PhaseAnimation phaseTwo;
  PhaseAnimation phaseThree;

  bool showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    phaseOne = new PhaseAnimation(Colors.red);
    phaseTwo = new PhaseAnimation(Colors.yellow);
    phaseThree = new PhaseAnimation(Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Progress Button Animation App"),
        ),
        body: new Center(
          child: new ProgressButton(
              child: new Row(children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 120),
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                phaseOne,
                phaseTwo,
                new Stack(children: <Widget>[
                  phaseThree,
                  Visibility(
                    child:
                        new Positioned(left: 9.0, child: new Icon(Icons.check)),
                    visible: showCheckIcon,
                  ),
                ])
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
              onPressed: () async {
                phaseOne.Run();
                await Future.delayed(const Duration(seconds: 5));
                phaseTwo.Run();
                phaseOne.Stop();
                await Future.delayed(const Duration(seconds: 5));
                phaseThree.Run();
                phaseTwo.Stop();
                await Future.delayed(const Duration(seconds: 5));
                phaseThree.Stop();

                phaseOne.Move(2.0);
                phaseTwo.Move(1.0);

                await Future.delayed(const Duration(seconds: 2));
                setState(() {
                  showCheckIcon = true;
                });
              }),
        ));
  }
}
