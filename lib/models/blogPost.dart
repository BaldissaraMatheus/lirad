import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  String title;
  DateTime lastUpdate;
  String link;
  String img;

  BlogPost(this.title, this.lastUpdate, this.link, this.img);
}