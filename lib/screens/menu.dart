import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/routes.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/models/route.dart';
import 'package:frontend/widgets/rainbow_heart.dart';
import 'package:provider/provider.dart';
import 'package:frontend/config/palette.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiradUser user = Provider.of<LiradUser>(context, listen: false);
    bool showCertificados = [user.ligante, user.extensionista, user.praticas].contains(true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Menu', style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),),
      ),
      body: Container(
        margin: EdgeInsets.all(6),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Flexible(child:_createMenuItem(context, NamedRoutes.QUIZES.name, Palette.black, Icons.list_alt, Row, true, _navigateToRoute(context, NamedRoutes.QUIZES)), flex: 1,),
                        SizedBox(height: 6,),
                        Flexible(child: _createMenuItem(context, NamedRoutes.CALENDAR.name, Palette.black, Icons.calendar_today, Row, true, _navigateToRoute(context, NamedRoutes.CALENDAR)), flex: 1,),
                      ],
                    ),
                  ),
                  SizedBox(width: 6,),
                  Flexible(child: _createMenuItem(context, NamedRoutes.RANDOM_QUIZES.name, Palette.yellow, Icons.shuffle, Column, false, _navigateToRoute(context, NamedRoutes.RANDOM_QUIZES)), flex: 1,),
                ],
              )
            ),
            SizedBox(height: 6,),
             _createMenuItem(context, NamedRoutes.VIDEOS.name, Palette.black, Icons.play_arrow, Row, true,  _navigateToRoute(context, NamedRoutes.VIDEOS), 75),
            SizedBox(height: 6,),
            showCertificados
              ? _createMenuItem(context, NamedRoutes.CERTIFICADOS.name, Palette.black, Icons.filter_frames_rounded, Row, true, _navigateToRoute(context, NamedRoutes.CERTIFICADOS), 75)
              : Container(),
            showCertificados ? SizedBox(height: 6,) : Container(),
            _createMenuItem(context, NamedRoutes.BLOG.name, Palette.black, Icons.book, Row, true, _navigateToRoute(context, NamedRoutes.BLOG), 75),
            SizedBox(height: 6,),
            Container(
              child: Row(
                children: [
                  Flexible(child:_createMenuItem(context, 'Sobre', Palette.black, Icons.info_outline, Row, true, _openSobreDialog(context), 75), flex: 1,),
                  SizedBox(width: 6,),
                  Flexible(child:_createMenuItem(context, NamedRoutes.LOGOUT.name, Palette.darkBlue, Icons.logout, Row, true, _navigateToRoute(context, NamedRoutes.LOGOUT), 75), flex: 1,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createMenuItem(BuildContext context, String title, Color color, IconData icon, Type orientation, bool dark, Function fn, [double height]) {
    final textColor = dark ? Palette.white : Palette.black;
    final children = [
      Icon(icon, color: textColor,),
      SizedBox(height: 6, width: 6,),
      Text(title, style: TextStyle(color: textColor),)
    ];
    final mainAxisAlignment =  MainAxisAlignment.center;
    return GestureDetector(
      onTap: fn,
      child: Container(
        color: color,
        height: height,
        child: orientation == Column
          ? Align(alignment: Alignment.center, child: Column(children: children, mainAxisAlignment: mainAxisAlignment,))
          : Align(alignment: Alignment.center, child: Row(children: children, mainAxisAlignment: mainAxisAlignment,)),
      ),      
    );
  }

  Function _navigateToRoute(BuildContext context, LiradRoute route) {
    return () => Navigator.of(context).pushNamed(route.path);
  }

  Function _openSobreDialog(BuildContext context) {    
    final credits = 'Aplicativo foi desenvolvido em conjunto por Vitor Lobo, Cleiton Magno, '
      + 'Bianca Vivarini, Rodolfo L. Carneiro e Matheus Baldissara.';    
    final defaultTextStyle = TextStyle(color: Colors.black);
    final icons = [
      TextSpan(text: '\n \nOs ícones utilizados na tela de simulados foram baixados da endereço ', style: defaultTextStyle),
      TextSpan(text: 'https://icons8.com/', style: new TextStyle(color: Colors.blue), recognizer: new TapGestureRecognizer()
        ..onTap = () {
          launch('https://icons8.com/');
        },
      ),
      TextSpan(text: '.')
    ];
    final thankYou = '\n \n Obrigado por baixar o app!';    
    return () => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Sobre o aplicativo'),
        content: Column(
            mainAxisSize: MainAxisSize.min,            
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(text: credits, style: defaultTextStyle),
                ...icons,
                TextSpan(text: thankYou, style: defaultTextStyle),
              ])),
              SizedBox(height: 12,),
              RainbowHeart()
            ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context, rootNavigator: true).pop(), child: Text('OK')),
        ],
      ),
    );
  }
}
