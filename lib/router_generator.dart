import 'package:flutter/material.dart';
import 'package:frontend/screens/video_list.dart';

import './screens/menu.dart';
import 'screens/quiz_list.dart';
import 'screens/quiz.dart';

// TODO incluir pagina de erro
class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;
    Map<String, Widget> routes = {
      '/': Menu(),
      '/quizes': QuizList(),
      '/quizes/quiz': QuizScreen(quiz: args),
      '/videos': VideoListScreen()
    };
    Widget screen = routes[settings.name];
    return MaterialPageRoute(builder: (_) => screen);
  }
}