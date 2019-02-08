import 'package:flutter/material.dart';
import 'package:flutter_progress_button_animation/progress_button.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<Home>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut);
    _opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Click...',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  new FadeTransition(
                      opacity: _opacityAnimation,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 130.0),
                        width: 22.0,
                        height: 22.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: new LinearGradient(
                            begin: FractionalOffset.center,
                            end: FractionalOffset.topCenter,
                            colors: [Colors.red, Colors.white],
                          ),
                        ),
                      )),
                  new FadeTransition(
                      opacity: _opacityAnimation,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        width: 22.0,
                        height: 22.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: new LinearGradient(
                            begin: FractionalOffset.center,
                            end: FractionalOffset.topCenter,
                            colors: [Colors.yellow, Colors.white],
                          ),
                        ),
                      )),
                  new FadeTransition(
                      opacity: _opacityAnimation,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        width: 22.0,
                        height: 22.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: new LinearGradient(
                            begin: FractionalOffset.center,
                            end: FractionalOffset.topCenter,
                            colors: [Colors.green, Colors.white],
                          ),
                        ),
                      ))
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
                  setState(() {
                    _controller.forward();
                  });
                })));
  }
}

enum FadeInPhase {
  /// The initial state.
  ///
  /// We do not yet know whether the target image is ready and therefore no
  /// animation is necessary, or whether we need to use the placeholder and
  /// wait for the image to load.
  start,

  /// Waiting for the target image to load.
  waiting,

  /// Fading out previous image.
  fadeOut,

  /// Fading in new image.
  fadeIn,

  /// Fade-in complete.
  completed,
}
