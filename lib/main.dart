import 'package:flutter/material.dart';
import 'quiz.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questao =
    'Dizem que Humboldt, naturalista do século XIX, maravilhado pela geografia,'
    + 'flora e fauna da região sulamericana, via seus habitantes como se fossem mendigos sentados sobre um saco de ouro,'
    + 'referindo-se a suas incomensuráveis riquezas naturais não exploradas. De alguma maneira,'
    + 'o cientista ratificou nosso papel de exportadores de natureza no que seria o mundo depois da colonização ibérica:'
    + 'enxergou-nos como territórios condenados a aproveitar os recursos naturais existentes.\n \n'
    + 'ACOSTA, A. _Bem viver_: uma oportunidade para imaginar outros mundos. São Paulo: Elefante, 2016 (adaptado).\n \n'
    + 'A relação entre o ser humano e a natureza ressaltada no texto refletia a permanência da seguinte corrente filosófica:';

  var answers = [
    'Relativismo Cognitivo',
    'Materialismo Dialético',
    'Racionalismo Cartesiano',
    'Pluralismo Epistemológico',
    'Existencialismo Fenomenológico'
  ];

  void foo() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
       ),
      body: Quiz(question: questao, answers: answers, rightAnswerIndex: 2,)
    ),);
  }
}