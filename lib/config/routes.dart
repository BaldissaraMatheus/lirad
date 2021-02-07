import 'package:frontend/models/route.dart';

class NamedRoutes {
  static var MENU = Route('/', 'Menu', false);
  static var LOGOUT = Route('/logout', 'Sair da sua conta', false);
  static var QUIZES = Route('/quizes', 'Simulados', false);
  static var QUIZES_QUIZ = Route('/quizes/quiz', 'quiz', false);
  static var VIDEOS = Route('/videos', 'Vídeos', false);
  static var CERTIFICADOS = Route('/certificates', 'Certificados', true);
  static var CALENDAR = Route('/activities', 'Calendário de Atividades', false);
  static var BLOG = Route('/blog', 'Blog', false);
}