import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LiradUser extends ChangeNotifier {
  String uid;
  String email;
  String photoURL;
  String displayName;
  List<String> favoriteQuestions;

  LiradUser([this.uid, this.email, this.photoURL, this.displayName, this.favoriteQuestions]);

  factory LiradUser.fromMap(Map<String, dynamic> profile) {
    return LiradUser(
      profile['uid'],
      profile['email'],
      profile['photoURL'],
      profile['displayName'],
      profile['favoriteQuestions'].cast<String>()
    );
  }

  factory LiradUser.fromUser(User user) {
    return LiradUser(
      user.uid,
      user.email,
      user.photoURL,
      user.displayName,
      []
    );
  }

  void updateUser(LiradUser user) {
    uid = user.uid;
    email = user.email;
    photoURL = user.photoURL;
    displayName = user.displayName;
    favoriteQuestions = user.favoriteQuestions;
  }

  void setFavoriteQuestions(List<String> favoriteQuestions) {
    this.favoriteQuestions = favoriteQuestions;
  }

  List<String> getFavoriteQuestions() {
    return this.favoriteQuestions;
  }

}