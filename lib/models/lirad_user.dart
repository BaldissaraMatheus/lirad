import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LiradUser extends ChangeNotifier {
  String uid;
  String email;
  String photoURL;
  String displayName;
  List<String> favoriteQuestions;
  bool praticas;
  bool ligante;
  bool extensionista;

  LiradUser([this.uid, this.email, this.photoURL, this.displayName, this.favoriteQuestions, this.praticas, this.ligante, this.extensionista]);

  factory LiradUser.fromMap(Map<String, dynamic> profile) {
    return LiradUser(
      profile['uid'],
      profile['email'],
      profile['photoURL'],
      profile['displayName'],
      profile['favoriteQuestions'].cast<String>(),
      profile['praticas'],
      profile['ligante'],
      profile['extensionista']
    );
  }

  factory LiradUser.fromUser(User user) {
    return LiradUser(
      user.uid,
      user.email,
      user.photoURL,
      user.displayName,
      [],
      false,
      false,
      false
    );
  }

  void updateUser(LiradUser user) {
    uid = user.uid;
    email = user.email;
    photoURL = user.photoURL;
    displayName = user.displayName;
    favoriteQuestions = user.favoriteQuestions;
    praticas = user.praticas;
    ligante = user.ligante;
    extensionista = user.extensionista;
  }

  void setFavoriteQuestions(List<String> favoriteQuestions) {
    this.favoriteQuestions = favoriteQuestions;
  }

  List<String> getFavoriteQuestions() {
    return this.favoriteQuestions;
  }
}