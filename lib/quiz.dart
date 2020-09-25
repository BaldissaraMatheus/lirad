import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final String question;
  final String reference;
  final List<String> answers;
  final int rightAnswerIndex;
  int selectedAnswerIndex;

  Quiz({this.question, this.answers, this.rightAnswerIndex, this.reference});
  
  @override
  _QuizState createState() => new _QuizState();
}

class _QuizState extends State<Quiz> {
  final dataKey = new GlobalKey();

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
              Container(margin: EdgeInsets.only(top: 12), child: this._getSendButton()),
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
  RaisedButton _getSendButton() {
    var maxWidthChild = this._getMaxWidthChild('Enviar');
    var isAnyAnswerSelected = widget.selectedAnswerIndex != null;
    var selectedAnswerOrZero = isAnyAnswerSelected ? widget.selectedAnswerIndex : 0;
    var selectedAnswer = widget.answers[selectedAnswerOrZero];
    var rightAnswer = widget.answers[widget.rightAnswerIndex];
    var isSelectedAnswerCorrect = selectedAnswer == rightAnswer ? 'Resposta correta!' : 'Resposta errada!';
    var color = isAnyAnswerSelected ? Colors.blue : Colors.grey[600];

    return RaisedButton(
      key: dataKey,
      child: maxWidthChild,
      color: color,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: color)
      ),
      onPressed: () => isAnyAnswerSelected
        ? showDialog(
          context: this.context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: Text(isSelectedAnswerCorrect),
            content: Text('Resposta correta: ' + rightAnswer),
            actions: [
              FlatButton(child: null, onPressed: null,)
            ],
          ),
        )
        : null,
    );
  }
  RaisedButton _buildRaisedButton(String text, int index) {
    var maxWidthChild = this._getMaxWidthChild(text);
    var color = index != null && index == widget.selectedAnswerIndex ? Colors.blue : Colors.deepPurple[400];
    return RaisedButton(
      child: maxWidthChild,
      color: color,
      textColor: Colors.white,
      onPressed: () => {
        Scrollable.ensureVisible(dataKey.currentContext),
        setState(() => widget.selectedAnswerIndex = index)
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: color)
      ),
    );
  }
  SizedBox _getMaxWidthChild(String text) {
    return SizedBox(width: double.infinity, child: Text(text, textAlign: TextAlign.center,),);
  }
}

