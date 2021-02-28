import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';
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

void main(List<String> args) async {
  // https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = await authService.currentUser;
  runApp(LiradApp(user));
}

class LiradApp extends StatelessWidget {
  LiradUser user;

  LiradApp(this.user);

  @override
  Widget build(BuildContext context) {
    final route = user.email == null ? '/login' : '/';
    return ChangeNotifierProvider(
      create: (context) => user,
      child: MaterialApp(
        theme: theme,
        initialRoute: route,
        onGenerateRoute: RouterGenerator.generate,
      )
    );
  }
}
