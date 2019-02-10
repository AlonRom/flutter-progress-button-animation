import 'package:flutter/material.dart';

class PhaseAnimation extends StatefulWidget {
  final PhaseAnimationState phaseState = PhaseAnimationState();
  final MaterialColor dominantColor;

  PhaseAnimation(this.dominantColor);

  @override
  State<StatefulWidget> createState() => phaseState;

  void Run() {
    phaseState.run();
  }

  void Stop() {
    phaseState.stop();
  }

  void Move(double dx) {
    phaseState.move(dx);
  }
}

class PhaseAnimationState extends State<PhaseAnimation>
    with TickerProviderStateMixin {
  String _state = "processing";

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _opacityAnimation;

  AnimationController _controller2;
  Animation<double> _animation2;
  Animation<Offset> _phasePosition;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(_controller);

    _controller2 = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation2 =
        CurvedAnimation(parent: _controller2, curve: Curves.easeInOut);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == "processing") {
      return new FadeTransition(
          opacity: _opacityAnimation,
          child: new Container(
            margin: const EdgeInsets.only(left: 8.0),
            width: 18.0,
            height: 18.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              gradient: new LinearGradient(
                begin: FractionalOffset.center,
                end: FractionalOffset.topCenter,
                colors: [widget.dominantColor, Colors.white],
              ),
            ),
          ));
    } else {
      return new SlideTransition(
          position: _phasePosition,
          child: new FadeTransition(
              opacity: _opacityAnimation,
              child: new Container(
                margin: const EdgeInsets.only(left: 8.0),
                width: 18.0,
                height: 18.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: new LinearGradient(
                    begin: FractionalOffset.center,
                    end: FractionalOffset.topCenter,
                    colors: [widget.dominantColor, Colors.white],
                  ),
                ),
              )));
    }
  }

  void run() {
    _controller.forward();
  }

  void stop() {
    _controller.stop();
  }

  void move(double dx) {
    setState(() {
      _state = "test";
      _phasePosition = Tween<Offset>(begin: Offset.zero, end: Offset(dx, 0.0))
          .animate(_controller2);
      _controller2.forward();
    });
  }
}
