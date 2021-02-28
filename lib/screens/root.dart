import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:provider/provider.dart';

import '../router_generator.dart';

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

class RootScreen extends StatefulWidget {
  LiradUser user;

  RootScreen(this.user);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  @override
  Widget build(BuildContext context) {
    final getRoute = (user) => user.email == null ? '/login' : '/';
    return ChangeNotifierProvider(
      create: (context) => widget.user,
      child: MaterialApp(
        theme: theme,
        initialRoute: getRoute(widget.user),
        onGenerateRoute: RouterGenerator.generate,
      )
    );
  }
}