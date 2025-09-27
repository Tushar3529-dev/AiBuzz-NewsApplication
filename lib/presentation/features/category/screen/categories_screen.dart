/* import 'package:aibuzz_newsapp/data/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/domain/repository/news_view_model.dart';
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: categoryName == categoriesList[index]
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            categoriesList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<CaterogiesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.black),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.articles == null ||
                      snapshot.data!.articles!.isEmpty) {
                    return const Center(child: Text("No news available"));
                  }

                  final articles = snapshot.data!.articles!;

                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];

                      final imageUrl = article.urlToImage ?? "";

                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                newImage: snapshot
                                    .data!
                                    .articles![index]
                                    .urlToImage
                                    .toString(),
                                newsTitle: snapshot.data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!
                                    .articles![index]
                                    .publishedAt
                                    .toString(),
                                author: snapshot.data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!
                                    .articles![index]
                                    .description
                                    .toString(),
                                content: snapshot.data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!
                                    .articles![index]
                                    .source!
                                    .name
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  placeholder: (context, url) =>
                                      Center(child: spinKit2),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            snapshot
                                                .data!
                                                .articles![index]
                                                .source!
                                                .name
                                                .toString(),
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            maxLines: 1,
                                            format.format(dateTime),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
 */

import 'package:aibuzz_newsapp/data/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/domain/repository/news_view_model.dart';
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final NewsViewModel newsViewModel = NewsViewModel();
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
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 🔹 Category selector
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

            // 🔹 News list by category
            Expanded(
              child: FutureBuilder<categoriesModel.CaterogiesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.black),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData ||
                      snapshot.data!.articles == null ||
                      snapshot.data!.articles!.isEmpty) {
                    return const Center(child: Text("No news available"));
                  }

                  final articles = snapshot.data!.articles!;
                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return CategoryArticleTile(
                        article: article,
                        width: width,
                        height: height,
                        format: format,
                        spinKit: spinKit2,
                      );
                    },
                  );
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

/// 🔹 Category Chip Widget
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.blue : Colors.blueGrey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
      ),
    );
  }
}

/// 🔹 Category Article Tile Widget
class CategoryArticleTile extends StatelessWidget {
  final categoriesModel.Articles article;
  final double width, height;
  final DateFormat format;
  final Widget spinKit;

  const CategoryArticleTile({
    super.key,
    required this.article,
    required this.width,
    required this.height,
    required this.format,
    required this.spinKit,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage ?? "";
    final dateTime =
        DateTime.tryParse(article.publishedAt ?? "") ?? DateTime.now();

    return InkWell(
      onTap: () => _openDetail(context, article),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: height * .18,
                width: width * .3,
                placeholder: (context, url) => Center(child: spinKit),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline, color: Colors.red),
              ),
            ),
            Expanded(
              child: Container(
                height: height * .18,
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Text(
                      article.title ?? "",
                      maxLines: 3,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          article.source?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          format.format(dateTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Navigate to Detail Screen
void _openDetail(BuildContext context, categoriesModel.Articles article) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewsDetailScreen(
        newImage: article.urlToImage ?? "",
        newsTitle: article.title ?? "",
        newsDate: article.publishedAt ?? "",
        author: article.author ?? "",
        description: article.description ?? "",
        content: article.content ?? "",
        source: article.source?.name ?? "",
      ),
    ),
  );
}
