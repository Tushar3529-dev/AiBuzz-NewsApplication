/* import 'package:aibuzz_newsapp/data/model/categories_news_model.dart';
import 'package:aibuzz_newsapp/data/model/news_channels_headlines_model.dart';
import 'package:aibuzz_newsapp/domain/repository/news_view_model.dart';
import 'package:aibuzz_newsapp/presentation/features/category/screen/categories_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

enum FliterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _NewsFeedPageState extends State<NewsFeedPage> {
  NewsViewModel newsViewModel = NewsViewModel();

  FliterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesScreen()),
            );
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: 30,
            height: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "News Page ",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (FliterList item) {
              if (FliterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (FliterList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (FliterList.alJazeera.name == item.name) {
                // ✅ FIXED
                name = 'al-jazeera-english';
              }
              if (FliterList.independent.name == item.name) {
                // ✅ FIXED
                name = 'independent';
              }
              if (FliterList.cnn.name == item.name) {
                // ✅ FIXED
                name = 'cnn';
              }
              if (FliterList.reuters.name == item.name) {
                // ✅ FIXED
                name = 'reuters';
              }

              setState(() {
                selectedMenu = item;
              });
            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<FliterList>>[
              PopupMenuItem<FliterList>(
                value: FliterList.bbcNews,
                child: Text("BBC News"),
              ),

              PopupMenuItem<FliterList>(
                value: FliterList.aryNews,
                child: Text("Ary News"),
              ),
              PopupMenuItem<FliterList>(
                value: FliterList.independent,
                child: Text("Independent News"),
              ),
              PopupMenuItem<FliterList>(
                value: FliterList.reuters,
                child: Text("Reuters News"),
              ),
              PopupMenuItem<FliterList>(
                value: FliterList.cnn,
                child: Text("Cnn News"),
              ),

              PopupMenuItem<FliterList>(
                value: FliterList.alJazeera,
                child: Text("Al Jazeera News"),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
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
                  scrollDirection: Axis.horizontal,
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
                      child: SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * .02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Center(child: spinKit2),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.all(15),
                                  height: height * 0.22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!
                                                  .articles![index]
                                                  .source!
                                                  .name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CaterogiesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
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
                  shrinkWrap: true,
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
                      child: Container(
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
                                            snapshot
                                                .data!
                                                .articles![index]
                                                .source!
                                                .name
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget spinKit2 = const SpinKitFadingCircle(color: Colors.amber, size: 50);
}
 */

import 'package:aibuzz_newsapp/data/model/news_channels_headlines_model.dart'
    as headlinesModel;
import 'package:aibuzz_newsapp/data/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/domain/repository/news_view_model.dart';
import 'package:aibuzz_newsapp/presentation/features/category/screen/categories_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/details/screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

enum FliterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _NewsFeedPageState extends State<NewsFeedPage> {
  final NewsViewModel newsViewModel = NewsViewModel();

  FliterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesScreen()),
            );
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: 30,
            height: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "News Page ",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [_buildChannelMenu()],
      ),
      body: ListView(
        children: [
          // 🔹 Headlines Section
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<headlinesModel.NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
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
                  scrollDirection: Axis.horizontal,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return HeadlineCard(
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

          // 🔹 Categories Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<categoriesModel.CaterogiesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return CategoryNewsTile(
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
    );
  }

  // 🔹 Popup Menu Extracted
  Widget _buildChannelMenu() {
    return PopupMenuButton(
      initialValue: selectedMenu,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (FliterList item) {
        if (FliterList.bbcNews.name == item.name) name = 'bbc-news';
        if (FliterList.aryNews.name == item.name) name = 'ary-news';
        if (FliterList.alJazeera.name == item.name) name = 'al-jazeera-english';
        if (FliterList.independent.name == item.name) name = 'independent';
        if (FliterList.cnn.name == item.name) name = 'cnn';
        if (FliterList.reuters.name == item.name) name = 'reuters';

        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (context) => <PopupMenuEntry<FliterList>>[
        const PopupMenuItem(value: FliterList.bbcNews, child: Text("BBC News")),
        const PopupMenuItem(value: FliterList.aryNews, child: Text("Ary News")),
        const PopupMenuItem(
          value: FliterList.independent,
          child: Text("Independent News"),
        ),
        const PopupMenuItem(
          value: FliterList.reuters,
          child: Text("Reuters News"),
        ),
        const PopupMenuItem(value: FliterList.cnn, child: Text("Cnn News")),
        const PopupMenuItem(
          value: FliterList.alJazeera,
          child: Text("Al Jazeera News"),
        ),
      ],
    );
  }

  Widget spinKit2 = const SpinKitFadingCircle(color: Colors.amber, size: 50);
}

/// 🔹 Headline Card
class HeadlineCard extends StatelessWidget {
  final headlinesModel.Articles article;
  final double width, height;
  final DateFormat format;
  final Widget spinKit;

  const HeadlineCard({
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
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height * 0.6,
              width: width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: height * .02),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: spinKit),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline, color: Colors.red),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(15),
                  height: height * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.7,
                        child: Text(
                          article.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.source?.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              format.format(dateTime),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Category News Tile
class CategoryNewsTile extends StatelessWidget {
  final categoriesModel.Articles article;
  final double width, height;
  final DateFormat format;
  final Widget spinKit;

  const CategoryNewsTile({
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
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          format.format(dateTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
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

/// 🔹 Helper to open detail screen
void _openDetail(BuildContext context, dynamic article) {
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
