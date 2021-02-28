import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/screens/root.dart';
import 'package:frontend/services/auth.dart';

void main(List<String> args) async {
  // https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StreamSubscription<User> sub;
  sub = FirebaseAuth.instance.authStateChanges().listen((authUser) async {
    LiradUser user;
    if (authUser == null) {
      user = LiradUser();
    } else {
      user = await authService.getLiradUserFromUser(authUser);
    }
    sub.cancel();
    runApp(LiradApp(user));
  });
}

class LiradApp extends StatelessWidget {
  LiradUser user;

  LiradApp(this.user);

  @override
  Widget build(BuildContext context) {
    return RootScreen(user);
  }
}
