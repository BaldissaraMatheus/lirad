import 'package:flutter/material.dart';
import '../services/instagram.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  @override
  void initState() {
    redirect();
  }
    
  void redirect() async {
    await InstagramService.redirect();
    Navigator.popAndPushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor, // Red
            ),
          ),
        ), 
    );
  }
}