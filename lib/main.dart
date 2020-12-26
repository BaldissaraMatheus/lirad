import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
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
  FirebaseMessaging fm = FirebaseMessaging();
  var token = await fm.getToken();
  print(token);
  fm.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      // _showItemDialog(message);
    },
    // onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      // _navigateToItemDetail(message);
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      // _navigateToItemDetail(message);
    },
  );
  runApp(LiradApp());
}

class LiradApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LiradUser(),
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        // ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        //   create: (context) => CartModel(),
        //   update: (context, catalog, cart) {
        //     cart.catalog = catalog;
        //     return cart;
        //   },
        // ),
      child: MaterialApp(
        theme: theme,
        initialRoute: '/',
        onGenerateRoute: RouterGenerator.generate,
      )
    );
  }
}
