import 'package:flutter/material.dart';
import 'package:frontend/config/routes.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/models/route.dart';
import 'package:provider/provider.dart';
import 'package:frontend/config/palette.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiradUser user = Provider.of<LiradUser>(context, listen: false);

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
                        Flexible(child:_createRouteItem(context, Palette.black, Icons.list_alt, NamedRoutes.QUIZES, Row, true), flex: 1,),
                        SizedBox(height: 6,),
                        Flexible(child: _createRouteItem(context, Palette.black, Icons.calendar_today, NamedRoutes.CALENDAR, Row, true), flex: 1,),
                      ],
                    ),
                  ),
                  SizedBox(width: 6,),
                  Flexible(child: _createRouteItem(context, Palette.yellow, Icons.shuffle, NamedRoutes.RANDOM_QUIZES, Column, false), flex: 1,),
                ],
              )
            ),
            SizedBox(height: 6,),
             _createRouteItem(context, Palette.black, Icons.play_arrow, NamedRoutes.VIDEOS, Row, true, 75),
            SizedBox(height: 6,),
            [user.ligante, user.extensionista, user.praticas].contains(true)
              ? _createMenuItem(context, Palette.black, Icons.filter_frames_rounded, NamedRoutes.CERTIFICADOS, Row, true, 75)
              : Container(),
            user.ligante == true ? SizedBox(height: 6,) : Container(),
            _createRouteItem(context, Palette.black, Icons.book, NamedRoutes.BLOG, Row, true, 75),
            SizedBox(height: 6,),
            _createRouteItem(context, Palette.darkBlue, Icons.logout, NamedRoutes.LOGOUT, Row, true, 75)
          ],
        ),
      ),
    );
  }

  _createRouteItem(BuildContext context, Color color, IconData icon, LiradRoute route, Type orientation, bool dark, [double height]) {
    final textColor = dark ? Palette.white : Palette.black;
    final children = [
      Icon(icon, color: textColor,),
      SizedBox(height: 6, width: 6,),
      Text(route.name, style: TextStyle(color: textColor),)
    ];
    final mainAxisAlignment =  MainAxisAlignment.center;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route.path),
      child: Container(
        color: color,
        height: height,
        child: orientation == Column
          ? Align(alignment: Alignment.center, child: Column(children: children, mainAxisAlignment: mainAxisAlignment,))
          : Align(alignment: Alignment.center, child: Row(children: children, mainAxisAlignment: mainAxisAlignment,)),
      ),      
    );
  }
}
