import 'package:instagram_media/instagram_media.dart';
import '../config/keys.dart';

class InstragramService {
  InstagramMedia foo() {
    return InstagramMedia(
         mediaTypes: 0, //choose what to return (see parameters below)
         appID: IG_KEY, //app ID for your IG app in your FB Developer Account
         appSecret: IG_SECRET_KEY
    );
  }
}