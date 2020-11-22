import 'package:frontend/models/quiz.dart';

class QuizScreenArguments {
  final List<Quiz> quizes;
  final int index;

  QuizScreenArguments(this.quizes, this.index);
}