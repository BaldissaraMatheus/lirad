import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final String question;
  final List<String> answers;
  final int rightAnswerIndex;

  Quiz({this.question, this.answers, this.rightAnswerIndex});
  
  @override
  _QuizState createState() => new _QuizState();
}

class _QuizState extends State<Quiz> {
  final dataKey = new GlobalKey();
  int selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("Quiz"),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                this._buildQuestionText(widget.question),
                // Text(widget.question, style: TextStyle(fontSize: 16,),),
                ...widget.answers.map((answer) => this._buildRaisedButton(answer, widget.answers.indexOf(answer))),
                Container(margin: EdgeInsets.only(top: 12), child: this._getSendButton()),
                // Container(margin: EdgeInsets.only(top: 12, bottom: 12), child: Text(widget.reference, style: TextStyle(fontSize: 12,),),),
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
      ),
    );
  }
  RaisedButton _getSendButton() {
    var maxWidthChild = this._getMaxWidthChild('Enviar');
    var isAnyAnswerSelected = this.selectedAnswerIndex != null;
    var selectedAnswerOrZero = isAnyAnswerSelected ? this.selectedAnswerIndex : 0;
    var selectedAnswer = widget.answers[selectedAnswerOrZero];
    var rightAnswer = widget.answers[widget.rightAnswerIndex];
    var isSelectedAnswerCorrect = selectedAnswer == rightAnswer ? 'Resposta correta!' : 'Resposta errada!';
    var color = !isAnyAnswerSelected
      ? Theme.of(context).primaryColor
      : Theme.of(context).accentColor;
    var textColor = !isAnyAnswerSelected
      ? Theme.of(context).primaryTextTheme.bodyText1.color
      : Theme.of(context).accentTextTheme.bodyText1.color;

    return RaisedButton(
      key: dataKey,
      child: maxWidthChild,
      color: color,
      // textColor: Theme.of(context).backgroundColor, // ??
      textColor: textColor,
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
    var isThisAnswerSelected = index != null && index == this.selectedAnswerIndex;
    var color = !isThisAnswerSelected
      ? Theme.of(context).primaryColor
      : Theme.of(context).accentColor;
    var textColor = !isThisAnswerSelected
      ? Theme.of(context).primaryTextTheme.bodyText1.color
      : Theme.of(context).accentTextTheme.bodyText1.color;
    return RaisedButton(
      child: maxWidthChild,
      color: color,
      textColor: textColor,
      onPressed: () => {
        Scrollable.ensureVisible(dataKey.currentContext),
        setState(() => this.selectedAnswerIndex = index)
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
  RichText _buildQuestionText(String question) {
    var questionList = question.split('_');
    // https://stackoverflow.com/a/622001
    var isEven = true;
    var italicPortion = questionList.where((element) => isEven = !isEven).toList();
    isEven = false;
    var notItalicPortion = questionList.where((element) => isEven = !isEven).toList(); 
    var newList = new List<TextSpan>();
    for (int i = 0; i < notItalicPortion.length - 1; i++) {
      newList.add(new TextSpan(text: notItalicPortion[i]));
      newList.add(new TextSpan(text: italicPortion[i], style: TextStyle(fontStyle: FontStyle.italic)));
    }
    newList.add(new TextSpan(text: notItalicPortion[notItalicPortion.length - 1]));

    var text = new RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: newList
      )
    );
    // print(questionList);
    return text;
  }
}
