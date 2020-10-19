class Article {
  String author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
      sourceName;

  Article(
      {this.author,
      this.description,
      this.title,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.url,
      this.sourceName});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      description: json['description'],
      title: json['title'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      sourceName: json['source']['name'],
    );
  }
}
