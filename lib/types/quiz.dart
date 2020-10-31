import 'package:cloud_firestore/cloud_firestore.dart';
import './answer.dart';

class Quiz {
  String title;
  String question;
  List<String> options;
  Answer answer;
  
  Quiz({ this.title, this.question, this.options, this.answer });

  Quiz.fromQueryDocumentSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    var data = queryDocumentSnapshot.data();
    this.title = data['title'];
    this.question = data['question'];
    this.options = data['options'].cast<String>();
    this.answer = new Answer(description: data['answer']['description'], index: data['answer']['index']);
  }
}