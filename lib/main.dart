import 'package:flutter/material.dart';
import 'quiz.dart';

const questao =
  'Dizem que Humboldt, naturalista do século XIX, maravilhado pela geografia,'
  + 'flora e fauna da região sulamericana, via seus habitantes como se fossem mendigos sentados sobre um saco de ouro,'
  + 'referindo-se a suas incomensuráveis riquezas naturais não exploradas. De alguma maneira,'
  + 'o cientista ratificou nosso papel de exportadores de natureza no que seria o mundo depois da colonização ibérica:'
  + 'enxergou-nos como territórios condenados a aproveitar os recursos naturais existentes.\n \n'
  + 'ACOSTA, A. _Bem viver_: uma oportunidade para imaginar outros mundos. São Paulo: Elefante, 2016 (adaptado).\n \n'
  + 'A relação entre o ser humano e a natureza ressaltada no texto refletia a permanência da seguinte corrente filosófica:';

  const answers = [
    'Relativismo Cognitivo',
    'Materialismo Dialético',
    'Racionalismo Cartesiano',
    'Pluralismo Epistemológico',
    'Existencialismo Fenomenológico'
  ];

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xffF0F0F0),
        primaryColor: Color(0xff14213D),
        accentColor: Color(0xffF1CD43),
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle()
        ).apply(
          bodyColor: Color(0xffF0F0F0),
          displayColor: Color(0xffF0F0F0)
        ),
        accentTextTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle()
        ).apply(
          bodyColor: Color(0xff171717),
          displayColor: Color(0xff171717)
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Menu(),
        '/quiz': (context) => Quiz(question: questao, answers: answers, rightAnswerIndex: 2,),
      },
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Abrir quiz'),
          onPressed: () {
            Navigator.pushNamed(context, '/quiz');
            // Navigate to the second screen when tapped.
          },
        ),
      ),
    );
  }
}

// class MyAppState extends State<MyApp> {
//   var questao =
//     'Dizem que Humboldt, naturalista do século XIX, maravilhado pela geografia,'
//     + 'flora e fauna da região sulamericana, via seus habitantes como se fossem mendigos sentados sobre um saco de ouro,'
//     + 'referindo-se a suas incomensuráveis riquezas naturais não exploradas. De alguma maneira,'
//     + 'o cientista ratificou nosso papel de exportadores de natureza no que seria o mundo depois da colonização ibérica:'
//     + 'enxergou-nos como territórios condenados a aproveitar os recursos naturais existentes.\n \n'
//     + 'ACOSTA, A. _Bem viver_: uma oportunidade para imaginar outros mundos. São Paulo: Elefante, 2016 (adaptado).\n \n'
//     + 'A relação entre o ser humano e a natureza ressaltada no texto refletia a permanência da seguinte corrente filosófica:';

//   var answers = [
//     'Relativismo Cognitivo',
//     'Materialismo Dialético',
//     'Racionalismo Cartesiano',
//     'Pluralismo Epistemológico',
//     'Existencialismo Fenomenológico'
//   ];

//   void foo() {
//     setState(() {

//     });
//   }
// }