import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tem certeza que deseja sair?', style: TextStyle(fontSize: 18),),
              Container(
                margin: EdgeInsets.only(top: 12),
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text('Confirmar'),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.bodyText1.color,
                      onPressed: () => authService.signOut(context)
                    ),
                    RaisedButton(
                      child: Text('Cancelar'),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.bodyText1.color,
                      onPressed: () => Navigator.of(context).popAndPushNamed('/')
                    ),
                  ]
                )
              )
            ],
          )
        ),
      ),
    );
  }
}