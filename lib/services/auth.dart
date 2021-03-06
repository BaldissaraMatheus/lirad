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

  Future<LiradUser> getLiradUserFromUser(User user) async {
    DocumentSnapshot ds = await _db.collection('users').doc(user.uid).get();
    return LiradUser.fromMap(ds.data());
  }

  Future<User> googleSignIn(context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
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
      liradUser.initializeFirebaseMessaging();
      currUser.updateUser(liradUser);

      print("signed in " + liradUser.displayName);
      Navigator.of(context).pushReplacementNamed('/');
      return user;
    } on PlatformException catch (platformError, platformStacktrace) {
      print(
          'Caught a platform exception in GoogleSignIn\n$platformError, $platformStacktrace');
    }
  }

  void updateUserData(LiradUser user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'favoriteQuestions': user.favoriteQuestions,
      'praticas': user.praticas,
      'ligante': user.ligante,
      'extensionista': user.extensionista
    }, SetOptions(merge: true));
  }

  Future<void> signOut(context) async {
    final logOuts = List<Future>();
    logOuts.add(_auth.signOut());
    logOuts.add(_googleSignIn.disconnect());
    Navigator.of(context).pushReplacementNamed('/login');
  }
}

final AuthService authService = AuthService();
