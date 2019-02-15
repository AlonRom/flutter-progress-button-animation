import 'package:flutter/material.dart';

class DoneAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DoneAnimationState();
}

class DoneAnimationState extends State<DoneAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  double imageSize = 0.0;
  final double imageFinalSize = 30.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _animation.addListener(() {
      setState(() {
        imageSize = imageFinalSize * _animation.value;
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.only(left: 60.0),
        child: new Image.asset(
          'assets/images/done.png',
          width: imageSize,
          height: imageSize,
        ));
  }
}
