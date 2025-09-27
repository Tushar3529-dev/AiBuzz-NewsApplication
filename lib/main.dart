import 'package:aibuzz_newsapp/data/local/model/article_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:aibuzz_newsapp/data/local/data%20source/article_local_data_source.dart';
import 'package:aibuzz_newsapp/data/local/repository/article_repository_impl.dart';
import 'package:aibuzz_newsapp/domain/repository/local/article_repository.dart';
import 'package:aibuzz_newsapp/presentation/features/boomarks/bloc/saved_articles_bloc.dart';
import 'package:aibuzz_newsapp/presentation/features/home/screen/home_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/splash/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // ✅ Initialize Hive
  await Hive.initFlutter();

  // ✅ Register adapter BEFORE opening box
  Hive.registerAdapter(ArticleHiveModelAdapter());

  // ✅ Open boxes
  await Hive.openBox('userBox');
  await Hive.openBox<ArticleHiveModel>('articlesBox');

  final userBox = Hive.box('userBox');
  final isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);

  // ✅ Setup repository + bloc
  final localDataSource = ArticleLocalDataSource();
  final ArticleRepository repository = ArticleRepositoryImpl(localDataSource);

  runApp(MyApp(isLoggedIn: isLoggedIn, repository: repository));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final ArticleRepository repository;

  const MyApp({super.key, required this.isLoggedIn, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SavedArticlesBloc(repository)..add(LoadSavedArticles()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLoggedIn ? const MainScreen() : const SplashScreen(),
      ),
    );
  }
}
