import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream<User> user;

  AuthService() {
    // user = _auth.authStateChanges();
    // liradUser = user.switchMap((User user) {
    //   if (user != null) {
    //     print('user found: ' + user.uid);
    //     return _db
    //       .collection('users')
    //       .doc(user.uid)
    //       .snapshots()
    //       .map((snap) => LiradUser.fromMap(snap.data()));
    //   } else {
    //     print('user not found.');
    //     return Stream.value(null);
    //   }
    // });
  }

  Stream<LiradUser> get user {
    return _auth.authStateChanges().map(
      (User user) => user == null
        ? LiradUser.fromUser(user)
        : null
    );
  }

  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = (await _auth.signInWithCredential(credential)).user;
      LiradUser liradUser = LiradUser.fromUser(user);  
      updateUserData(liradUser);

      print("signed in " + liradUser.displayName);

      return user;

    } on PlatformException catch (platformError, platformStacktrace) {
      print(
        'Caught a platform exception in GoogleSignIn\n$platformError, $platformStacktrace'
      );
    }
  }

  void updateUserData(LiradUser user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'favoriteQuestions': user.favoriteQuestions
    }, SetOptions(merge: true));
  }

  void signOut(context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }
}

final AuthService authService = AuthService();
