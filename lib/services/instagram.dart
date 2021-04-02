import 'package:url_launcher/url_launcher.dart';

class InstagramService {
  static Future<bool> redirect() async {
    var url = 'https://www.instagram.com/liradufrj/';

    if (await canLaunch(url)) {
      return launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}