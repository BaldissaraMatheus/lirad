import 'package:flutter/material.dart';
import 'package:frontend/config/routes.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/models/route.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiradUser user = Provider.of<LiradUser>(context, listen: false);
    var routes = [
      NamedRoutes.QUIZES,
      NamedRoutes.RANDOM_QUIZES,
      NamedRoutes.CALENDAR,
      NamedRoutes.CERTIFICADOS,
      NamedRoutes.BLOG,
      NamedRoutes.VIDEOS,
      NamedRoutes.LOGOUT,
    ];
    var accessibleRoutes = user.ligante == true
      ? routes
      : routes.where((route) => route.restrictToLigante == false).toList();

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
                        Flexible(child:_createRouteItem(context, Icons.list_alt, NamedRoutes.QUIZES, Row), flex: 1,),
                        SizedBox(height: 6,),
                        Flexible(child: _createRouteItem(context, Icons.calendar_today, NamedRoutes.CALENDAR, Row), flex: 1,),
                      ],
                    ),
                  ),
                  SizedBox(width: 6,),
                  Flexible(child: _createRouteItem(context, Icons.shuffle, NamedRoutes.RANDOM_QUIZES, Column), flex: 1,),
                ],
              )
            ),
            SizedBox(height: 6,),
             _createRouteItem(context, Icons.play_arrow, NamedRoutes.VIDEOS, Row, 75),
            SizedBox(height: 6,),
            user.ligante == true
              ? _createRouteItem(context, Icons.filter_frames_rounded, NamedRoutes.CERTIFICADOS, Row, 75)
              : Container(),
            user.ligante == true ? SizedBox(height: 6,) : Container(),
            _createRouteItem(context, Icons.book, NamedRoutes.BLOG, Row, 75),
            SizedBox(height: 6,),
            _createRouteItem(context, Icons.logout, NamedRoutes.LOGOUT, Row, 75)
          ],
        ),
      ),
    );
  }

  _createRouteItem(BuildContext context, IconData icon, LiradRoute route, Type orientation, [double height]) {
    final children = [Icon(icon, color: Colors.white,), SizedBox(height: 6, width: 6,), Text(route.name, style: TextStyle(color: Colors.white),)];
    final mainAxisAlignment =  MainAxisAlignment.center;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route.path),
      child: Container(
        color: Theme.of(context).primaryColor,
        height: height,
        child: orientation == Column
          ? Align(alignment: Alignment.center, child: Column(children: children, mainAxisAlignment: mainAxisAlignment,))
          : Align(alignment: Alignment.center, child: Row(children: children, mainAxisAlignment: mainAxisAlignment,)),
      ),      
    );
  }
}
