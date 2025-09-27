/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),

              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, ulr) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          ),

          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Text(
                  widget.newsTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height * .02),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .12),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.bookmark, color: Colors.black),
      ),
    );
  }
}
 */

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    DateTime dateTime = DateTime.tryParse(widget.newsDate) ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          // 🔹 Top Image
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),

          // 🔹 Content Card
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                _headline(widget.newsTitle),
                SizedBox(height: height * .02),
                _sourceAndDate(widget.source, format.format(dateTime)),
                SizedBox(height: height * .12),
                _description(widget.description),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: implement bookmark save
        },
        child: const Icon(Icons.bookmark, color: Colors.black),
      ),
    );
  }

  /// 🔹 Headline Text
  Widget _headline(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  /// 🔹 Source and Date Row
  Widget _sourceAndDate(String source, String date) {
    return Row(
      children: [
        Expanded(
          child: Text(
            source,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 🔹 Description
  Widget _description(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
