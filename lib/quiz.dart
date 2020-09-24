import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final String question;
  final String reference;
  final List<String> answers;
  final int rightAnswerIndex;
  int selectedAnswer;

  Quiz({this.question, this.answers, this.rightAnswerIndex, this.reference});
  
  @override
  _QuizState createState() => new _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(20),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              Text(widget.question, style: TextStyle(fontSize: 16,),),
              Container(margin: EdgeInsets.only(top: 12, bottom: 12), child: Text(widget.reference, style: TextStyle(fontSize: 12,),),),
              ...widget.answers.map((answer) => this._buildRaisedButton(answer, widget.answers.indexOf(answer))),
              // Expanded(
              //   child: Align(
              //     alignment: FractionalOffset.bottomCenter,
              //     child: MaterialButton(
              //       onPressed: () => {},
              //       child: this._buildRaisedButton('Enviar')
              //     ),
              //   ),
              // ),
            ],),
          )
        )
      )
    );
  }
  RaisedButton _buildRaisedButton(String text, int index) {
    var maxWidthChild = SizedBox(width: double.infinity, child: Text(text, textAlign: TextAlign.center,),);
    var color = index != null && index == widget.selectedAnswer ? Colors.blue : Colors.deepPurple[400];
    return RaisedButton(
      child: maxWidthChild,
      onPressed: () => setState(() => widget.selectedAnswer = index), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: color)
      ),
      color: color,
      textColor: Colors.white,
    );
  }
  void _checkAnswer() {
    var index = 0;
    if (index == widget.rightAnswerIndex) {
      print('acertou');
    } else {
      print('errou');
    }
  }
}

