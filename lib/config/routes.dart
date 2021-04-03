import 'package:frontend/models/route.dart';

class NamedRoutes {
  static var MENU = LiradRoute('/', 'Menu', false);
  static var LOGOUT = LiradRoute('/logout', 'Sair da sua conta', false);
  static var QUIZES = LiradRoute('/quizes', 'Simulados', false);
  static var QUIZES_QUIZ = LiradRoute('/quizes/quiz', 'quiz', false);
  static var VIDEOS = LiradRoute('/videos', 'Vídeos', false);
  static var CERTIFICADOS = LiradRoute('/certificates', 'Certificados', true);
  static var CALENDAR = LiradRoute('/activities', 'Calendário', false);
  static var BLOG = LiradRoute('/blog', 'Instagram', false);
  static var RANDOM_QUIZES = LiradRoute('/quizes/random', 'Questões', false);
}