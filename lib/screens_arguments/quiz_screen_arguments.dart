import 'package:frontend/models/quiz.dart';

class QuizScreenArguments {
  final List<Quiz> quizes;
  final int index;
  final String initialRoute;

  QuizScreenArguments(this.quizes, this.index, this.initialRoute);
}