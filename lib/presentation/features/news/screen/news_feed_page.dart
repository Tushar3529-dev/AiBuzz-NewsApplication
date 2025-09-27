import 'package:aibuzz_newsapp/data/remote/model/news_channels_headlines_model.dart'
    as headlinesModel;
import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/domain/repository/remote/news_view_model.dart';
import 'package:aibuzz_newsapp/presentation/features/category/screen/categories_screen.dart';

import 'package:aibuzz_newsapp/presentation/features/news/widgets/category_news_tile.dart';
import 'package:aibuzz_newsapp/presentation/features/news/widgets/headline_card.dart';

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
          //  Headlines Section
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

          //  Categories Section
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

  //  Popup Menu Extracted
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
