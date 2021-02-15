import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/models/quiz.dart';
import 'package:frontend/screens_arguments/quiz_screen_arguments.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  List<Quiz> quizes;
  int index;

  QuizScreen(QuizScreenArguments args) {
    this.quizes = args.quizes;
    this.index = args.index;
  }
  
  @override
  _QuizScreenState createState() => new _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  LiradUser user;
  bool isQuestionFavorite;
  final dataKey = new GlobalKey();
  int selectedOptionIndex;

  @override
  void initState() {
    this.user = Provider.of<LiradUser>(context, listen: false);
    this.updateIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(widget.quizes[widget.index].title),
            actions: [
              IconButton(
                icon: Icon(isQuestionFavorite ? Icons.favorite : Icons.favorite_outline),
                onPressed: () {
                  setFavorite(!this.isQuestionFavorite); 
                })
            ],
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
              Navigator.pushReplacementNamed(context, '/quizes');
            }),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                this._buildQuestionText(widget.quizes[widget.index].question),
                ...widget.quizes[widget.index].options.map((option) => 
                  this._buildRaisedButton(option.description, widget.quizes[widget.index].options.indexOf(option))),
                Container(margin: EdgeInsets.only(top: 12), child: this._getSendButton()),
              ],),
            )
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Theme.of(context).primaryColor.withOpacity(this._isQuizIndexLast() ? 0.5 : 1),
            selectedItemColor: Theme.of(context).primaryColor.withOpacity(this._isQuizIndexFirst() ? 0.5 : 1),
            unselectedFontSize: 14,
            selectedFontSize: 14,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.west),
                label: 'Questão Anterior',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.east),
                label: 'Próxima Questão',
              )
            ],
           onTap: _onBottomNavigationBarItemTapped, 
          ),
        )
      ),
    );
  }
  RaisedButton _getSendButton() {
    var maxWidthChild = this._getMaxWidthChild('Enviar');
    var isAnyOptionSelected = this.selectedOptionIndex != null;
    var selectedOptionOrZero = isAnyOptionSelected ? this.selectedOptionIndex : 0;
    var selectedOption = widget.quizes[widget.index].options[selectedOptionOrZero];
    var rightAnswer = widget.quizes[widget.index].options[widget.quizes[widget.index].answer];
    var isSelectedAnswerCorrect = selectedOption == rightAnswer ? 'Resposta correta!' : 'Resposta errada!';
    var color = !isAnyOptionSelected
      ? Theme.of(context).primaryColor
      : Theme.of(context).accentColor;
    var textColor = !isAnyOptionSelected
      ? Theme.of(context).primaryTextTheme.bodyText1.color
      : Theme.of(context).accentTextTheme.bodyText1.color;

    return RaisedButton(
      key: dataKey,
      child: maxWidthChild,
      color: color,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: color)
      ),
      onPressed: () => isAnyOptionSelected
        ? showDialog(
          context: this.context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: Text(isSelectedAnswerCorrect),
            content: Text(selectedOption.explanation),
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
    var isThisOptionSelected = index != null && index == this.selectedOptionIndex;
    var color = !isThisOptionSelected
      ? Theme.of(context).primaryColor
      : Theme.of(context).accentColor;
    var textColor = !isThisOptionSelected
      ? Theme.of(context).primaryTextTheme.bodyText1.color
      : Theme.of(context).accentTextTheme.bodyText1.color;
    return RaisedButton(
      child: maxWidthChild,
      color: color,
      textColor: textColor,
      onPressed: () => {
        Scrollable.ensureVisible(dataKey.currentContext),
        setState(() => this.selectedOptionIndex = index)
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
    var questionWithLineBreaks = question.replaceAll("\\n", "\n");
    var questionList = questionWithLineBreaks.split('_');
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
        style: TextStyle(fontSize: 16, color: Colors.black, ),
        children: newList
      )
    );
    // print(questionList);
    return text;
  }
  void _onBottomNavigationBarItemTapped(int value) {
    this.resetState();
    if (value == 0 && this._isQuizIndexFirst()) {
      return;
    }
    if (value == 1 && this._isQuizIndexLast()) {
      return;
    }
    var operand = value == 0 ? -1 : 1;
    setState(() {
      widget.index += operand;
    });
    this.updateIsFavorite();
  }
  bool _isQuizIndexFirst() {
    return widget.index == 0;
  }
  bool _isQuizIndexLast() {
    return widget.index == widget.quizes.length - 1;
  }
  void resetState() {
    this.selectedOptionIndex = null;
  }
  void updateIsFavorite() {
    setState(() {
      final title = widget.quizes[widget.index].title;
      this.isQuestionFavorite = user.favoriteQuestions.indexOf(title) != -1;  
    });
    
  }
  void setFavorite(bool favorite) {
    setState(() {
      this.isQuestionFavorite = favorite;
    });
    final favorites = this.user.favoriteQuestions;
    final favoriteTitle = widget.quizes[widget.index].title;
    if (favorite) {
      favorites.add(favoriteTitle);
    } else {
      favorites.removeWhere((title) => title == favoriteTitle);
    }
    user.setFavoriteQuestions(favorites);
    authService.updateUserData(user);
  }
}
