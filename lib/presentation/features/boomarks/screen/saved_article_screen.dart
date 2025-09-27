import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';
import 'package:aibuzz_newsapp/presentation/features/boomarks/bloc/saved_articles_bloc.dart';
import 'package:aibuzz_newsapp/presentation/features/boomarks/widget/saved_article_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Articles")),
      body: BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
        builder: (context, state) {
          if (state is SavedArticlesLoaded) {
            if (state.articles.isEmpty) {
              return const Center(child: Text("No saved articles"));
            }
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final ArticleEntity article = state.articles[index];
                return SavedArticleTile(
                  article: article,
                  index: index,
                  width: width,
                  height: height,
                  format: format,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
