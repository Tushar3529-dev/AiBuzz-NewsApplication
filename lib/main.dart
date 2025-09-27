import 'package:aibuzz_newsapp/presentation/features/home/screen/home_screen.dart';
import 'package:aibuzz_newsapp/presentation/features/login/screen/login_page.dart';
import 'package:aibuzz_newsapp/presentation/features/news/screen/news_feed_page.dart';
import 'package:aibuzz_newsapp/presentation/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('userBox'); // 👈 Box to store login session

  final userBox = Hive.box('userBox');
  final isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? const MainScreen() : const SplashScreen(),
    );
  }
}
