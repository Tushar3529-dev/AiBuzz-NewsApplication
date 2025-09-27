import 'package:aibuzz_newsapp/data/local/data%20source/article_local_data_source.dart';
import 'package:aibuzz_newsapp/data/local/repository/article_repository_impl.dart';
import 'package:aibuzz_newsapp/data/remote/repository/news_repository.dart'; // 👈 import
import 'package:aibuzz_newsapp/domain/repository/local/article_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aibuzz_newsapp/main.dart';

void main() {
  testWidgets('App launches and shows Login screen when not logged in', (
    tester,
  ) async {
    // ✅ Create repository instances
    final articleRepository = ArticleRepositoryImpl(ArticleLocalDataSource());
    final newsRepository = NewsRepository();

    // ✅ Pump MyApp with both repositories
    await tester.pumpWidget(
      MyApp(
        isLoggedIn: false,
        repository: articleRepository,
        newsRepository: newsRepository,
      ),
    );

    // ✅ Verify that Login screen shows up initially
    expect(find.text('Login'), findsOneWidget);
  });
}
