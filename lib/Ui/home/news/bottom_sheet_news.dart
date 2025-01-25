import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/provider/themeProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetNews extends StatefulWidget {
  const BottomSheetNews({super.key, required this.news});
  final News news;

  @override
  State<BottomSheetNews> createState() => _BottomSheetNewsState();
}

class _BottomSheetNewsState extends State<BottomSheetNews> {
  @override
  Widget build(BuildContext context) {
    
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDarkTheme = themeProvider.isDark();

  
    final backgroundColor = isDarkTheme ? AppColors.whiteColor : AppColors.blackColor;
    final buttonColor = isDarkTheme ? AppColors.blackColor : AppColors.whiteColor;
    final buttonTextColor = isDarkTheme ? AppColors.whiteColor : AppColors.blackColor;

    var height = MediaQuery.of(context).size.height;

    return Container(
      color: backgroundColor, 
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: widget.news.urlToImage?.isNotEmpty == true
                    ? widget.news.urlToImage!
                    : "https://via.placeholder.com/150",
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 40,
                  color: AppColors.redColor,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              widget.news.content ?? "No content available",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: buttonColor,
                  ),
            ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor, 
                foregroundColor: buttonTextColor,
              ),
              onPressed: () {
                if (widget.news.url != null && widget.news.url!.isNotEmpty) {
                  _launchURL(widget.news.url!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No URL available")),
                  );
                }
              },
              child: Text("View All Article",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }
}
