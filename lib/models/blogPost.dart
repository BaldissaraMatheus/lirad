import 'package:intl/intl.dart';

class BlogPost {
  DateTime _lastUpdate;
  String title;
  String lastUpdate;
  String link;
  String img;

  BlogPost(this.title, DateTime lastUpdate, this.link, this.img) {
    this._lastUpdate = lastUpdate;
    this.lastUpdate = new DateFormat('dd/MM/yyyy').format(lastUpdate);
  }

  DateTime getUnparsedLastUpdate() {
    return _lastUpdate;
  }
}