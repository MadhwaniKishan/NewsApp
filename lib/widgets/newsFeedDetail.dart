import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/article.dart';
import 'package:flutter_news_app/utility/utilityClass.dart';

class NewsFeedDetail extends StatelessWidget {
  final Article _article;

  NewsFeedDetail(this._article);

  @override
  Widget build(BuildContext context) {
    String _formattedDate = Utility.getFormattedDate(_article.publishedAt);
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _article.urlToImage != null
                  ? Image.network(_article.urlToImage)
                  : Image.asset('assets/images/newsfeed.jpg'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  _article.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Text(
                (_article.author != null ? _article.author : "Annonymus ") +
                    " | " +
                    _formattedDate,
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  _article.content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
