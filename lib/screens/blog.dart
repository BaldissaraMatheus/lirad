import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:frontend/models/blogPost.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';
import '../services/instagram.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<BlogPost> _posts;
  final webViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    getPosts();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: _posts != null
        ? ListView(children: _posts.map((post) => _buildPostCard(post, context)).toList())
        : Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor, // Red
            ),
          ),
        ), 
    );
  }

  Widget _buildPostCard(BlogPost post, context) {
    return GestureDetector(
      onTap: () { _launchURL(post.link); },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(12),
            child: Column(
              children: [
                CachedNetworkImage(imageUrl: post.img),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Column(children: [
                    Row(children: [Text(post.title, style: TextStyle(fontSize: 16))]),
                    Row(children: [Text(post.lastUpdate.toString())])
                  ]),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
    
  void getPosts() async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => 
          InstragramService().foo()
      )
    );
    // final baseUrl = 'www.medium.com';
    // final userName = '/feed/@carolinalacerda';
    // final uri = Uri.https(baseUrl, userName);
    // final res = await http.get(uri);
    // if (res.statusCode != 200) {
    //   _posts = [];
    //   return;
    // }
    // final doc = XmlDocument.parse(res.body);
    // final posts = doc.findAllElements('item');
    // setState(() {
    //   final blogPosts = posts.map((post) {
    //     final title = post.findAllElements('title').first.text;
    //     final date = post.findAllElements('atom:updated').first.text;
    //     final link = post.findAllElements('guid').first.text;
    //     final content = post.findAllElements('content:encoded').first.text;
    //     final srcRegex = new RegExp('src\s*=\s*"(.+?)"');
    //     final src = srcRegex.firstMatch(content).group(0);
    //     final img = src.substring(5, src.length - 1);
    //     return BlogPost(title, DateTime.parse(date), link, img);
    //   }).toList();
    //   blogPosts.sort((a, b) => a.getUnparsedLastUpdate().isAfter(b.getUnparsedLastUpdate()) ? 0 : 1);
    //   _posts = blogPosts;
    // });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}