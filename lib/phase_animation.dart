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
}

class PhaseAnimationState extends State<PhaseAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
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
              colors: [widget.dominantColor, Colors.white],
            ),
          ),
        ));
  }

  void run() {
    _controller.forward();
  }

  void stop() {
    _controller.stop();
  }
}
