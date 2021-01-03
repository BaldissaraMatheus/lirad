import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<LiradUser> get user {
    return _auth.authStateChanges().map(
      (User user) => user == null
        ? LiradUser.fromUser(user)
        : null
    );
  }

  Future<User> googleSignIn(context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential uc = await _auth.signInWithCredential(credential);
      User user = uc.user;
      DocumentSnapshot ds = await _db.collection('users').doc(user.uid).get();
      LiradUser liradUser;
      if (ds.data() == null) {
        liradUser = LiradUser.fromUser(user);
      } else {
        liradUser = LiradUser.fromMap(ds.data());
      }
      LiradUser currUser = Provider.of<LiradUser>(context, listen: false);
      updateUserData(liradUser);
      currUser.updateUser(liradUser);

      print("signed in " + liradUser.displayName);
      Navigator.of(context).pushReplacementNamed('/');
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
