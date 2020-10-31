class NewsModel {
  String author;
  String title;
  String description;
  String url;

  NewsModel({this.author, this.title, this.description, this.url});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );
  }
}
