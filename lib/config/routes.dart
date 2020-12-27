import 'package:frontend/models/route.dart';

class NamedRoutes {
  static var MENU = Route('/', 'Menu');
  static var LOGOUT = Route('/logout', 'Sair da sua conta');
  static var QUIZES = Route('/quizes', 'Abrir lista de simulados e questões');
  static var QUIZES_RANDOM = Route('/quizes/random', 'Abrir uma questão aleatória');
  static var QUIZES_QUIZ = Route('/quizes/quiz', 'quiz');
  static var VIDEOS = Route('/videos', 'Abrir lista de vídeos');
}