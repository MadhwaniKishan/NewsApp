import 'article.dart';

class Articles {
  List<Article> articles;

  String status;

  Articles({this.articles, status});

  factory Articles.fromJson(Map<String, dynamic> json) {
    List<Article> articles = (json['articles'] as List)
        .map((article) => Article.fromJson(article))
        .toList();
    return Articles(
      articles: articles,
      status: json['status'],
    );
  }
}
