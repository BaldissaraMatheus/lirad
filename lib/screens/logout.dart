import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 160, 0, 0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text('Tem certeza que deseja sair?', style: TextStyle(fontSize: 18),),
                  Container(
                    padding: EdgeInsets.fromLTRB(100, 20, 100, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          RaisedButton(
                            child: Text('Confirmar'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryTextTheme.bodyText1.color,
                            onPressed: () => authService.signOut(context)
                          ),
                        ]),
                        Column(children: [
                          RaisedButton(
                            child: Text('Cancelar'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryTextTheme.bodyText1.color,
                            onPressed: () => Navigator.of(context).popAndPushNamed('/')
                          ),
                        ]),
                      ]
                    )
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}