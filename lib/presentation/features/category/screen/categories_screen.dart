import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/presentation/features/category/bloc/categories_bloc.dart';
import 'package:aibuzz_newsapp/presentation/features/category/bloc/categories_event.dart';
import 'package:aibuzz_newsapp/presentation/features/category/bloc/categories_state.dart';
import 'package:aibuzz_newsapp/presentation/features/category/widgets/category_article_title.dart';
import 'package:aibuzz_newsapp/presentation/features/category/widgets/category_chip.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  final List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    // Load default category (General) when screen opens
    context.read<CategoriesBloc>().add(LoadCategoriesNews(categoryName));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //  Category selector
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final category = categoriesList[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        categoryName = category;
                      });
                      //  Trigger bloc event when category changes
                      context.read<CategoriesBloc>().add(
                        LoadCategoriesNews(categoryName),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CategoryChip(
                        label: category,
                        isSelected: categoryName == category,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            //  News list by category (from Bloc)
            Expanded(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.black),
                    );
                  } else if (state is CategoriesError) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else if (state is CategoriesLoaded) {
                    final articles = state.articles;
                    if (articles.isEmpty) {
                      return const Center(child: Text("No news available"));
                    }
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final categoriesModel.Articles article =
                            articles[index];
                        return CategoryArticleTile(
                          article: article,
                          width: width,
                          height: height,
                          format: format,
                          spinKit: spinKit2,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget spinKit2 = const SpinKitFadingCircle(color: Colors.amber, size: 50);
}
