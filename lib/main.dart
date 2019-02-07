import 'package:flutter/material.dart';
import 'package:flutter_progress_button_animation/home.dart';

void main() => runApp(StartApp());

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Progress Bar Animation App",
        home: Home());
  }
}
