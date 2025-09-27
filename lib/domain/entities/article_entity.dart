class ArticleEntity {
  final String title;
  final String? description;
  final String? urlToImage; // <-- make this nullable
  final String source;
  final String publishedAt;
  final String? content;
  final String? author;
  final String? url;

  ArticleEntity({
    required this.title,
    this.description,
    this.urlToImage,
    required this.source,
    required this.publishedAt,
    this.author,
    this.content,
    this.url,
  });
}
