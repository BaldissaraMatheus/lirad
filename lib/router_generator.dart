import 'package:flutter/material.dart';
import 'package:frontend/screens/activities.dart';
import 'package:frontend/screens/blog.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/logout.dart';
import 'package:frontend/screens/video_list.dart';
import 'package:frontend/screens/certificates.dart';

import './screens/menu.dart';
import 'screens/quiz_list.dart';
import 'screens/quiz.dart';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;
    Map<String, Widget> routes = {
      '/': Menu(),
      '/quizes': QuizList(),
      '/quizes/quiz': args != null ? QuizScreen(args) : Menu(),
      '/videos': VideoListScreen(),
      '/logout': LogoutScreen(),
      '/login': LoginScreen(),
      '/activities': ActivitiesScreen(),
      '/certificates': CertificatesScreen(),
      '/blog': BlogScreen() 
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