import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/api/apiProvider.dart';
import 'package:flutter_news_app/bloc/articleBloc.dart';
import 'package:flutter_news_app/bloc/event.dart';
import 'package:flutter_news_app/bloc/state.dart';
import 'package:flutter_news_app/utility/utilityClass.dart';
import 'package:flutter_news_app/widgets/newsFeedDetail.dart';

import 'model/article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleBloc(LoadingData(), ApiProvider()),
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'News Feed'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<ArticleBloc>(context).add(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ArticleBloc, DataState>(
        builder: (context, state) {
          if (state is LoadingData) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Success) {
            return getListView(state.articlesObject.articles);
          } else if (state is Failure) {
            return Center(child: Text('Data fetching failed'));
          } else {
            return Text('');
          }
        },
      ),
    );
  }

  Widget getListView(List<Article> articles) {
    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return NewsFeedDetail(articles[index]);
                }),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),
              child: Card(elevation: 2, child: getItem(articles[index])),
            ),
          );
        },
      ),
    );
  }

  Widget getItem(Article article) {
    final int days = Utility.getDifferenceInDaysFromToday(article.publishedAt);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              article.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(days.toString() + " days ago"),
          ),
          Text(article.sourceName),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              article.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: article.urlToImage != null
                ? Image.network(article.urlToImage)
                : Image.asset('assets/images/newsfeed.jpg'),
          ),
        ],
      ),
    );
  }
}
