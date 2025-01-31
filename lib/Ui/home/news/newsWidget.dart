import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/news/Cubit/news_view_model.dart';
import 'package:news_app/Ui/home/news/news_item.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:news_app/Ui/home/news/Cubit/newsState.dart';
import 'package:news_app/Models/sourseResponce.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.source});
  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late ScrollController _scrollController;
  late NewsViewModel _newsViewModel;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _newsViewModel = NewsViewModel();
    _loadNews();
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id) {
      setState(() {
        _newsViewModel.newsList.clear();
        _newsViewModel.currentPage = 1;
        _newsViewModel.hasMore = true;
        _loadNews();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        _newsViewModel.hasMore) {
      _loadNews();
    }
  }

  void _loadNews() {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    String currentLanguage = languageProvider.appLanguage;
    _newsViewModel.getNews(widget.source.id!, currentLanguage, _newsViewModel.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);

    return BlocProvider.value(
      value: _newsViewModel,
      child: BlocBuilder<NewsViewModel, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState && _newsViewModel.newsList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: isDarkTheme ? AppColors.whiteColor : AppColors.greyColor,
              ),
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Text(state.errorMessage!),
            );
          } else if (state is NewsSuccessState || _newsViewModel.newsList.isNotEmpty) {
            return Container(
              color: theme.scaffoldBackgroundColor,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _newsViewModel.newsList.length + 1,
                itemBuilder: (context, index) {
                  if (index < _newsViewModel.newsList.length) {
                    return NewsItem(news: _newsViewModel.newsList[index]);
                  } else {
                    return _newsViewModel.hasMore
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
                        : const SizedBox.shrink();
                  }
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
