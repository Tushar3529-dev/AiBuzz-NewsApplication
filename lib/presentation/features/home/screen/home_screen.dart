import 'package:aibuzz_newsapp/presentation/features/boomarks/screen/saved_article_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/category/screen/categories_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/news/screen/news_feed_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const NewsFeedPage(),
    const CategoriesScreen(),
    const SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
        ],
      ),
    );
  }
}
