import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),),
      ),
      body: Center(
        child: ListView(children: [
          RaisedButton(
            child: Text('Abrir questão aleatória'),
            onPressed: () {
              Navigator.of(context).pushNamed('/quizes/random');
            },
          ),
          RaisedButton(
            child: Text('Abrir lista de questões'),
            onPressed: () {
              Navigator.of(context).pushNamed('/quizes');
            },
          ),
          RaisedButton(
            child: Text('Abrir lista de vídeos'),
            onPressed: () {
              Navigator.of(context).pushNamed('/videos');
            },
          ),
        ],) 
      ),
    );
  }
}