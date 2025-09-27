class ArticleEntity {
  final String title;
  final String description;
  final String urlToImage;
  final String source;
  final String publishedAt;
  final String? content;
  final String? author;
  ArticleEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.source,
    required this.publishedAt,
    this.author,
    this.content,
  });
}
