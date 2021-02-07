import 'package:intl/intl.dart';

class BlogPost {
  String title;
  String lastUpdate;
  String link;
  String img;

  BlogPost(this.title, DateTime lastUpdate, this.link, this.img) {
    this.lastUpdate = new DateFormat('dd/MM/yyyy').format(lastUpdate);
  }
}