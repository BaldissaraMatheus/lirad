import 'package:flutter/material.dart';
import 'package:frontend/config/routes.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiradUser user = Provider.of<LiradUser>(context, listen: false);
    var routes = [
      NamedRoutes.QUIZES,
      NamedRoutes.VIDEOS,
      NamedRoutes.CALENDAR,
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
      body: Center(
        child: ListView.separated(
          padding: EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 0),
          separatorBuilder: (BuildContext context, int index) => Divider(height: 15,),
          itemCount: accessibleRoutes.length,
          itemBuilder: (_, index) {
            return this._createRaisedButton(context, accessibleRoutes[index].path, accessibleRoutes[index].desc);
          },
        )
      ),
    );
  }

  _createRaisedButton(BuildContext context, String route, String desc) {
    var sizedBox = SizedBox(
      height: 25,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(desc, textAlign: TextAlign.center),
      ) ,
    );
    var bgColor = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    return RaisedButton(
      padding: EdgeInsets.all(12),
      child: sizedBox,
      color: bgColor,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: bgColor)
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }

}
