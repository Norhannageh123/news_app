import 'package:flutter/material.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/Ui/home/news/news_item.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  NewsWidget({super.key, required this.source});
  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}
class _NewsWidgetState extends State<NewsWidget> {
  List<dynamic> articles = []; 
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _updateNews(); 
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id) {
      setState(() {
        articles.clear();
        currentPage = 1;
        hasMore = true;
        _updateNews();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        hasMore) {
      _updateNews();
    }
  }

  void _updateNews() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    String currentLanguage = languageProvider.appLanguage;

    try {
      var response = await ApiManager.getNewsbysourceId(
        widget.source.id!,
        currentLanguage,
        currentPage,
      );

      if (response != null && response.articles != null) {
        setState(() {
          articles.addAll(response.articles!); 
          currentPage++;
          hasMore = response.articles!.isNotEmpty; 
        });
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: articles.isEmpty && isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: isDarkTheme ? AppColors.whiteColor : AppColors.greyColor,
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: articles.length + 1, 
              itemBuilder: (context, index) {
                if (index < articles.length) {
                  return NewsItem(news: articles[index]); 
                } else {
                  return hasMore
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: isDarkTheme
                                  ? AppColors.whiteColor
                                  : AppColors.greyColor,
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                }
              },
            ),
    );
  }
}