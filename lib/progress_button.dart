import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const ProgressButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = 320.0,
    this.height = 50.0,
    this.onPressed,
    List<Widget> children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
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
        borderRadius: new BorderRadius.circular(25.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
