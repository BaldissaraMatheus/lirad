import 'package:flutter/material.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/random_quiz_opener.dart';
import 'package:frontend/screens/video_list.dart';

import './screens/menu.dart';
import 'screens/quiz_list.dart';
import 'screens/quiz.dart';

// TODO incluir pagina de erro
class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;
    print(args);
    Map<String, Widget> routes = {
      '/': Menu(),
      '/login': LoginScreen(),
      '/quizes': QuizList(),
      '/quizes/random': RandomQuizOpener(),
      '/quizes/quiz': args != null ? QuizScreen(args) : Menu(),
      '/videos': VideoListScreen()
    };
    Widget screen = routes[settings.name];
    return MaterialPageRoute(builder: (_) => screen);
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}