import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: []);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> user; // firebase user
  Stream<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = _auth.authStateChanges();
    profile = user.switchMap((User user) {

      if (user != null) {
        print(user);
        return _db
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snap) => snap.data());
      } else {
        return Stream.value({});
      }
    });
  }

  Future<User> googleSignIn() async {
    try {
      loading.add(true);
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      updateUserData(user);
  
      loading.add(false);

      print("signed in " + user.displayName);

      return user;

    } on PlatformException catch (platformError, platformStacktrace) {
      print(
        'Caught a platform exception in GoogleSignIn\n$platformError, $platformStacktrace'
      );
    }
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, SetOptions(merge: true));
  }


  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
