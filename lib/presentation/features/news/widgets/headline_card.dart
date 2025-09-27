import 'package:aibuzz_newsapp/data/remote/model/news_channels_headlines_model.dart'
    as headlinesModel;
import 'package:aibuzz_newsapp/presentation/utils/helpers/open_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      onTap: () => OpenDetailScreen.open(context, article),
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
    );
  }
}
