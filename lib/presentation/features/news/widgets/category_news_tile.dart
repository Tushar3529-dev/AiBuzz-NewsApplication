import 'package:aibuzz_newsapp/data/remote/model/categories_news_model.dart'
    as categoriesModel;
import 'package:aibuzz_newsapp/presentation/utils/helpers/open_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      onTap: () => OpenDetailScreen.open(context, article),
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
