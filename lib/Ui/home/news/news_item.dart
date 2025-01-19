import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_styles.dart';

class NewsItem extends StatefulWidget {
  NewsItem({super.key, required this.news});
  final News news;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  String formatTimeDifference(DateTime? publishedDate) {
    if (publishedDate == null) return "Unknown time";

    final now = DateTime.now();
    final difference = now.difference(publishedDate);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final publishedDate = DateTime.tryParse(widget.news.publishedAt ?? "");

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).indicatorColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.news.urlToImage ?? "",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: AppColors.greyColor,
              )),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 40,
                color: AppColors.redColor,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            widget.news.title ?? "",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "By: ${widget.news.author ?? ""}",
                  style: AppStyles.grey12Medium,
                ),
              ),
              Text(
                formatTimeDifference(publishedDate),
                style: AppStyles.grey12Medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
