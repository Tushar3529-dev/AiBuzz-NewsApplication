import 'package:aibuzz_newsapp/data/local/data%20source/article_local_data_source.dart';
import 'package:aibuzz_newsapp/data/local/repository/article_repository_impl.dart';
import 'package:aibuzz_newsapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    // ✅ Create repository (using your real implementation)
    final repository = ArticleRepositoryImpl(ArticleLocalDataSource());

    // ✅ Pump MyApp with dependencies
    await tester.pumpWidget(MyApp(isLoggedIn: false, repository: repository));

    // ✅ Verify that Login screen shows up initially
    expect(find.text('Login'), findsOneWidget);
  });
}
