import 'package:frontend/models/route.dart';

class NamedRoutes {
  static var MENU = Route('/', 'Menu');
  static var LOGIN = Route('/login', 'Login');
  static var QUIZES = Route('/quizes', 'Abrir lista de questões');
  static var QUIZES_RANDOM = Route('/quizes/random', 'Abrir uma questão aleatória');
  static var QUIZES_QUIZ = Route('/quizes/quiz', 'quiz');
  static var VIDEOS = Route('/videos', 'Abrir lista de vídeos');
}