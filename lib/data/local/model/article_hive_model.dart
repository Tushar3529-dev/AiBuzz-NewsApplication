import 'package:hive/hive.dart';

part 'article_hive_model.g.dart';

@HiveType(typeId: 0)
class ArticleHiveModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? urlToImage;

  @HiveField(3)
  String? source;

  @HiveField(4)
  String? publishedAt;

  @HiveField(5)
  String? url;

  @HiveField(6)
  String? author;

  @HiveField(7)
  String? content;

  ArticleHiveModel({
    this.title,
    this.description,
    this.urlToImage,
    this.source,
    this.publishedAt,
    this.url,
    this.author,
    this.content,
  });
}
