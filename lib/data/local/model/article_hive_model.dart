import 'package:hive/hive.dart';

part 'article_hive_model.g.dart';

@HiveType(typeId: 0) // Each Hive type needs unique ID
class ArticleHiveModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String urlToImage;

  @HiveField(3)
  String source;

  @HiveField(4)
  String publishedAt;

  ArticleHiveModel({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.source,
    required this.publishedAt,
  });
}
