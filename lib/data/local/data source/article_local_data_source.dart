import 'package:hive/hive.dart';
import 'package:aibuzz_newsapp/data/local/model/article_hive_model.dart';

class ArticleLocalDataSource {
  // ✅ Strongly typed Hive box (must be opened in main.dart before use)
  final Box<ArticleHiveModel> box = Hive.box<ArticleHiveModel>('articlesBox');

  Future<void> saveArticle(ArticleHiveModel article) async {
    await box.add(article);
  }

  Future<List<ArticleHiveModel>> getSavedArticles() async {
    return box.values.toList();
  }

  Future<void> deleteArticle(int index) async {
    await box.deleteAt(index);
  }
}
