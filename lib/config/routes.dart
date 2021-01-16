import 'package:frontend/models/route.dart';

class NamedRoutes {
  static var MENU = Route('/', 'Menu', false);
  static var LOGOUT = Route('/logout', 'Sair da sua conta', false);
  static var QUIZES = Route('/quizes', 'Abrir lista de simulados e questões', false);
  static var QUIZES_QUIZ = Route('/quizes/quiz', 'quiz', false);
  static var VIDEOS = Route('/videos', 'Abrir lista de vídeos', false);
  static var PAGINA_DO_LIGATE = Route('/videos', 'Página do Ligante', true);
  static var CALENDAR = Route('/activities', 'Calendário de Atividades', false);
}