import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/types/quiz.dart';

class QuizList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _QuisListState();
  }
}

class _QuisListState extends State<QuizList> {

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
        child: FutureBuilder(
          future: getQuizes(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,          
                itemBuilder: (_, index) {
                  return this._createButton(snapshot.data[index]);
              });
            } else {
              return Center(
                child: Text('Loading'),
              );
            }
          }
        )
      )
    );
  }

  Future<List<Quiz>> getQuizes() async {
    await Firebase.initializeApp();
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('quizes').get();
    return qn.docs.map((doc) => Quiz.fromQueryDocumentSnapshot(doc)).toList();
  }

  _createButton(Quiz quiz) {
    var maxWidthChild = this._getMaxWidthChild(quiz.title);
    var bgColor = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    return RaisedButton(
      child: maxWidthChild,
      color: bgColor,
      textColor: textColor,
      onPressed: () => {
        Navigator.of(context).pushNamed('/quizes/quiz', arguments: quiz)
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: bgColor)
      ),
    );
  }

  SizedBox _getMaxWidthChild(String text) {
    return SizedBox(width: double.infinity, child: Text(text, textAlign: TextAlign.center,),);
  }
}