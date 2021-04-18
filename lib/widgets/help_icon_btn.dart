import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpIconBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.help_outline_outlined,
      ),
      onPressed: () {
        showHelpModal(context);
      },
    );
  }

  dynamic showHelpModal(BuildContext context) {
    final defaultTextStyle = TextStyle(color: Colors.black);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Ajuda'),
        content: Column(
            mainAxisSize: MainAxisSize.min,            
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(text: 'Caso tenha qualquer dúvida sobre o uso do aplicativo, por favor entre em contato conosco através de ',
                  style: defaultTextStyle),
                TextSpan(text: 'nosso Instagram @liradufrj.', style: new TextStyle(color: Colors.blue), recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://www.instagram.com/liradufrj/');
                  },
                )
              ])),
            ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context, rootNavigator: true).pop(), child: Text('OK')),
        ]
      )
    );
  }
}

