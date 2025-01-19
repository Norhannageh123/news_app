import 'package:flutter/material.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/Ui/home/news/news_item.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  NewsWidget({super.key, required this.source});
  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late Future<NewsResponse?> futureNews;
  
  @override
  void initState() {
    super.initState();
    _updateNews();
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id) {
      _updateNews();
    }
  }

  void _updateNews() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);  
    String currentLanguage = languageProvider.appLanguage;  
    if (widget.source.id != null && widget.source.id!.isNotEmpty) {
      futureNews = ApiManager.getNewsbysourceId(widget.source.id!, currentLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);  
    String currentLanguage = languageProvider.appLanguage;  
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    var isDarkTheme = theme.brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: FutureBuilder<NewsResponse?>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: isDarkTheme ? AppColors.whiteColor : AppColors.greyColor,
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return _buildErrorWidget(context, height, width, isDarkTheme, appLocalizations);
          }

          if (snapshot.data!.status != "ok") {
            return _buildErrorWidget(context, height, width, isDarkTheme,
                appLocalizations, message: snapshot.data!.message ?? appLocalizations!.try_again);
          }

          var newsList = snapshot.data!.articles ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index]);
            },
            itemCount: newsList.length,
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, double height, double width,
      bool isDarkTheme, AppLocalizations? appLocalizations, {String message = ""}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline_outlined,
                  color: AppColors.redColor,
                  size: 40,
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Text(
                    message.isEmpty ? appLocalizations!.something_went_wrong : message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Image.asset(
              AppImages.error,
              height: height * 0.3,
              width: width * 0.2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              onPressed: () {
                setState(() {
                  _updateNews(); 
                });
              },
              child: Text(
                appLocalizations!.try_again,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
