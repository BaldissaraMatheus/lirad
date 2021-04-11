import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/config/palette.dart';
import 'package:rainbow_color/rainbow_color.dart';

class RainbowHeart extends StatefulWidget {
  @override
  _ColorTextState createState() => _ColorTextState();
}

class _ColorTextState extends State<RainbowHeart> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> _colorAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 5), vsync: this);
    _colorAnim = RainbowColorTween([
      Palette.black,
      Palette.darkBlue,
      Palette.yellow,
      Palette.darkBlue,
    ])
    .animate(controller)
      ..addListener(() { setState(() {}); })
      ..addStatusListener((status) => _statusListenerFn(status));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _statusListenerFn(status) {
    if (status == AnimationStatus.completed) {
      controller.reset();
      controller.forward();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.favorite, color: _colorAnim.value,);
  }
}