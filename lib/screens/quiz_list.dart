import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/filter.dart';
import 'package:frontend/models/quiz.dart';
import 'package:frontend/screens_arguments/quiz_screen_arguments.dart';

class QuizList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _QuisListState();
  }
}

class _QuisListState extends State<QuizList> {

  // https://stackoverflow.com/questions/61884007/how-to-stop-setstate-when-called-from-displaying-black-screen-with-loading-widge
  Future<List<Quiz>> futureQuizList;
  List<Quiz> quizList;
  List<Quiz> favorites = [];
  List<String> tags = [];
  List<Filter> filters = [
    Filter('Simulados', []),
    Filter('Questões favoritas', [])
  ];
  bool isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    futureQuizList = this.getQuizes();
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
        child: FutureBuilder(
          future: this.futureQuizList,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
                separatorBuilder: (BuildContext context, int index) => Divider(height: 15,),
                itemCount: this.quizList.length + 1,          
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return DropdownButton(
                      style: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color),
                      value: this.filters[0].key,
                      items: this.filters.map((filter) => DropdownMenuItem(child: Text(filter.key), value: filter.key,)).toList(),
                      onChanged: (item) => {
                        if (item.contains('Questões sobre ')) {
                          this._updateQuizes(
                            this.filters.where((filter) => filter.key == item).map((filter) => filter.quizes).toList()[0]
                          )
                        }
                      },
                    );
                  }
                  return this._createButton(this.quizList[index - 1]);
                },
              );
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
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('quizes').get();
    var quizList = qn.docs.map((doc) => Quiz.fromMap(doc.data())).toList();
    this.quizList = quizList;
    var tags = quizList
      .map((quiz) => quiz.tags)
      .expand((tag) => tag)
      .map((tag) => tag)
      .toSet()
      .toList();
    var filters = tags
      .map((tag) => Filter(
        'Questões sobre ' + tag,
        this.quizList.where((quiz) => quiz.tags.contains(tag)).toList()
      ));
    this.filters.addAll(filters);
    return quizList;
  }

  _createButton(Quiz quiz) {
    var maxWidthSizedBox = this._getMaxWidthSizedBox(quiz.title, quiz);
    var bgColor = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    return RaisedButton(
      child: maxWidthSizedBox,
      color: bgColor,
      textColor: textColor,
      onPressed: () => {
        Navigator.of(context).pushNamed('/quizes/quiz', arguments: new QuizScreenArguments(this.quizList, this.quizList.indexOf(quiz)))
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: bgColor)
      ),
    );
  }

  SizedBox _getMaxWidthSizedBox(String text, Quiz quiz) {
    var isQuizFavorite = this.favorites.indexOf(quiz) != -1;
    var onPressedFn = isQuizFavorite ? this._removeFavorite : this._addFavorite;
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(text, textAlign: TextAlign.center,),
          Spacer(),
          IconButton(icon: Icon(
            isQuizFavorite ? Icons.favorite : Icons.favorite_outline,
            color: Colors.white,
          ), onPressed: () => onPressedFn(quiz))
        ]
      )
    );
  }

  void _removeFavorite(Quiz quiz) {
    setState(() {
      this.favorites.remove(quiz);
    });
  }

  void _addFavorite(Quiz quiz) {
    setState(() {
      this.favorites.add(quiz);
    });
  }

  void _updateQuizes(List<Quiz> quizes) {
    setState(() {
      this.quizList = quizes;
      print(this.quizList);
    });
  }

}