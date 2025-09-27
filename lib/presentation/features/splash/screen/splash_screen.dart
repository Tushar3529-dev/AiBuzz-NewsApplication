import 'dart:async'; // ✅ Correct import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:aibuzz_newsapp/presentation/features/login/screen/login_page.dart';
import 'package:aibuzz_newsapp/presentation/features/news/screen/news_feed_page.dart'; // 👈 add your News Feed Page import

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final userBox = Hive.box('userBox');
    final isLoggedIn = userBox.get('isLoggedIn', defaultValue: false);

    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NewsFeedPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_pic.jpg',
            fit: BoxFit.cover,
            height: height * 0.5,
          ),
          SizedBox(height: height * 0.04),
          Text(
            'Top-HeadLines',
            style: GoogleFonts.anton(
              letterSpacing: 0.6,
              color: Colors.grey.shade700,
              fontSize: 24,
            ),
          ),
          SizedBox(height: height * 0.04),
          const SpinKitChasingDots(color: Colors.blue, size: 40),
        ],
      ),
    );
  }
}
