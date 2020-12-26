import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/filter.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/models/quiz.dart';
import 'package:frontend/models/simulado.dart';
import 'package:frontend/screens_arguments/quiz_screen_arguments.dart';
import 'package:frontend/services/auth.dart';
import 'package:provider/provider.dart';

class QuizList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _QuisListState();
  }
}

class _QuisListState extends State<QuizList> {

  // https://stackoverflow.com/questions/61884007/how-to-stop-setstate-when-called-from-displaying-black-screen-with-loading-widge
  Future<List<dynamic>> futureItemsList;
  List<dynamic> itemsList;
  List<Quiz> quizList;
  List<Simulado> simuladosList;
  List<Quiz> favorites = [];
  List<Filter> filters = [
    Filter('Simulados', [], Icon(Icons.article)),
    Filter('Questões favoritas', [], Icon(Icons.favorite))
  ];
  String selectedFilter = 'Simulados';
  LiradUser user;

  @override
  void initState() {
    super.initState();
    this.user = Provider.of<LiradUser>(context, listen: false);
    futureItemsList = this.getItems().then((value) =>
      this.favorites = this.quizList.where((quiz) =>
        this.user.favoriteQuestions.contains(quiz.title)
      ).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(this.user.toString())
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: this.futureItemsList,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
                separatorBuilder: (BuildContext context, int index) => Divider(height: 15,),
                itemCount: this.itemsList.length + 1,          
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return DropdownButton(
                      style: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color),
                      value: this.selectedFilter,
                      items: this.filters.map((filter) => this._createDropdownMenuItemFromFilter(filter)).toList(),
                      onChanged: (item) => {
                        this._updateSelectedFilter(item),
                        if (item.contains('Questões sobre ')) {
                          this._updateList(
                            this.filters.where((filter) => filter.key == item).map((filter) => filter.quizes).toList()[0]
                          )
                        } else if (item == 'Simulados') {
                          this._updateList(this.simuladosList)
                        } else if (item == 'Questões favoritas') {
                          this._updateList(this.favorites)
                        }
                      },
                    );
                  }
                  return this._createButton(this.itemsList[index - 1]);
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

  Future<List<dynamic>> getItems() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('quizes').get();
    var quizList = qn.docs.map((doc) => Quiz.fromMap(doc.data())).toList();
    this.quizList = quizList;
    this.simuladosList = await this.getSimulados();
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
    this.itemsList = this.simuladosList;
    return this.itemsList;
  }

  Future<List<Simulado>> getSimulados() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('simulados').get();
    return qn.docs.map((doc) => Simulado.fromMap(doc.data())).toList();
  }

  DropdownMenuItem<String> _createDropdownMenuItemFromFilter(Filter filter) {
    List<Widget> rowChildren = [];
    if (filter.icon != null) {
      rowChildren.add(filter.icon);
    } else {
      rowChildren.add(Icon(Icons.subject));
    }
    rowChildren.add(SizedBox(width: 10,),);
    rowChildren.add(Text(filter.key));
    return DropdownMenuItem(
      child: Row(children: rowChildren,),
      value: filter.key
    );
  }

  _createButton(dynamic item) {
    if (item is Quiz) {
      return this._createQuizButton(item);
    } else {
      return this._createSimuladoButton(item);
    }
  }
  _createQuizButton(Quiz quiz) {
    var isQuizFavorite = this.favorites.indexOf(quiz) != -1;
    var onPressedFn = isQuizFavorite ? this._removeFavorite : this._addFavorite;
    var favoriteBtn = IconButton(icon: Icon(
      isQuizFavorite ? Icons.favorite : Icons.favorite_outline,
      color: Colors.white,
    ), onPressed: () => onPressedFn(quiz));
    var maxWidthSizedBox = this._getMaxWidthSizedBox(quiz.title, favoriteBtn);
    var bgColor = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    var sequenceList = this.selectedFilter == 'Questões favoritas' ? this.favorites : this.quizList;
    return RaisedButton(
      child: maxWidthSizedBox,
      color: bgColor,
      textColor: textColor,
      onPressed: () => {
        Navigator.of(context).pushNamed('/quizes/quiz', arguments: new QuizScreenArguments(sequenceList, sequenceList.indexOf(quiz)))
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: bgColor)
      ),
    );
  }
  
  _createSimuladoButton(Simulado simulado) {
    var maxWidthSizedBox = this._getMaxWidthSizedBox(simulado.title);
    var bgColor = Theme.of(context).accentColor;
    var textColor = Theme.of(context).accentTextTheme.bodyText1.color;
    return RaisedButton(
      child: maxWidthSizedBox,
      color: bgColor,
      textColor: textColor,
      onPressed: () async => {
        Navigator.of(context).pushNamed('/quizes/quiz', arguments: new QuizScreenArguments(
          this.quizList.where((quiz) => simulado.quizesTitle.contains(quiz.title)).toList(),
          0
        ))
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: bgColor)
      ),
    );
  }

  SizedBox _getMaxWidthSizedBox(String text, [IconButton favoriteBtn]) {
    List<Widget> sizedBoxRowChildren = [
      Text(text, textAlign: TextAlign.center,),
    ];
    if (favoriteBtn != null) {
      sizedBoxRowChildren.add(Spacer());
      sizedBoxRowChildren.add(favoriteBtn);
    }
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(children: sizedBoxRowChildren)
    );
  }

  void _removeFavorite(Quiz quiz) {
    setState(() {
      this.favorites.remove(quiz);
    });
    this._updateUserFavoriteQuestions();
  }

  void _addFavorite(Quiz quiz) {
    setState(() {
      this.favorites.add(quiz);
    });
    this._updateUserFavoriteQuestions();
  }

  void _updateUserFavoriteQuestions() {
    user.setFavoriteQuestions(this.favorites.map((question) => question.title).toList());
    authService.updateUserData(user);
  }

  void _updateList(List<dynamic> items) {
    setState(() {
      this.itemsList = items;
    });
  }

  void _updateSelectedFilter(String filter) {
    setState(() {
      this.selectedFilter = filter;
    });
  }
}