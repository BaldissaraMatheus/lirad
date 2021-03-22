import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/quiz.dart';
import 'package:frontend/screens_arguments/quiz_screen_arguments.dart';

class RandomQuizOpener extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RandomQuizOpenerState();
  }
}

class _RandomQuizOpenerState extends State<RandomQuizOpener> {

  _RandomQuizOpenerState() {
    this.navigateToRandomQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Lista de Questões"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text('Loading'),
        )
      )
    );
  }

  void navigateToRandomQuiz() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('quizes').get();
    var quizes = qn.docs
      .map((doc) => new Quiz.fromMap(doc.data()))
      .toList()
      ..shuffle();
    Navigator.of(context).popAndPushNamed('/quizes/quiz', arguments: new QuizScreenArguments(quizes, 0, '/'));
  }
}