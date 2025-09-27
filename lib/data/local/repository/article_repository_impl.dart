import 'package:aibuzz_newsapp/data/local/data%20source/article_local_data_source.dart';
import 'package:aibuzz_newsapp/data/local/model/article_hive_model.dart';
import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';
import 'package:aibuzz_newsapp/domain/repository/local/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleLocalDataSource localDataSource;

  ArticleRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    final model = ArticleHiveModel(
      title: article.title,
      description: article.description,
      urlToImage: article.urlToImage,
      source: article.source,
      publishedAt: article.publishedAt,
      url: article.url ?? "",
      author: article.author,
      content: article.content,
    );
    await localDataSource.saveArticle(model);
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    final models = await localDataSource.getSavedArticles();
    return models
        .map(
          (m) => ArticleEntity(
            title: m.title ?? "No Title",
            description: m.description ?? "No Description",
            urlToImage: m.urlToImage ?? "",
            source: m.source ?? "Unknown",
            publishedAt: m.publishedAt ?? DateTime.now().toIso8601String(),
            url: m.url ?? "",
            author: m.author,
            content: m.content,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteArticle(int index) async {
    await localDataSource.deleteArticle(index);
  }
}
