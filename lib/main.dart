import 'package:flutter/material.dart';
import './config/palette.dart';
import 'router_generator.dart';

final theme = ThemeData(
  backgroundColor: Palette.white,
  primaryColor: Palette.darkBlue,
  accentColor: Palette.yellow,
  primaryTextTheme: TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle()
  ).apply(
    bodyColor: Palette.white,
    displayColor: Palette.white
  ),
  accentTextTheme: TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle()
  ).apply(
    bodyColor: Palette.black,
    displayColor: Palette.black
  ),
);

void main(List<String> args) {
  runApp(LiradApp());
}

class LiradApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generate,
    );
  }
}
