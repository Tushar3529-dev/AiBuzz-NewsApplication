import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<void> saveArticle(ArticleEntity article);
  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> deleteArticle(int index);
}
