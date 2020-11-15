import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/quiz.dart';

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
    await Firebase.initializeApp();
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('quizes').get();
    var length = qn.docs.length;
    var index = new Random().nextInt(length);
    var quiz = new Quiz.fromQueryDocumentSnapshot(qn.docs[index]);
    Navigator.of(context).popAndPushNamed('/quizes/quiz', arguments: quiz);
  }
}