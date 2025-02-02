import 'package:flutter/material.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/provider/languageProvider.dart';
import 'package:news_app/provider/themeProvider.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository_impl.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:provider/provider.dart';
import 'news_item.dart';

class SearchBarr extends StatefulWidget {
  final List<Source> sourceList;
  final int sourceNumber;

  const SearchBarr({
    super.key,
    required this.sourceNumber,
    required this.sourceList,
  });

  @override
  State<SearchBarr> createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  SearchController searchControllerr = SearchController();
  late NewsRepositoryContract newsRepositoryContract;

  @override
  void initState() {
    super.initState();
    searchControllerr.addListener(() {
      setState(() {});
    });

    // تهيئة newsRepositoryContract
    newsRepositoryContract = NewsRepositoryImpl(
      remoteNewsRepository: RemoteNewsRepositoryImpl(apiManager: ApiManager()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SearchAnchor(
      viewBackgroundColor: themeProvider.isDark() ? Colors.black : Colors.white,
      searchController: searchControllerr,
      viewElevation: 4.0,
      viewHintText: languageProvider.appLanguage == 'en' ? 'Search here...' : 'ابحث هنا...',
      textInputAction: TextInputAction.search,
      headerHintStyle: TextStyle(
        color: themeProvider.isDark() ? Colors.white : Colors.black,
      ),
      headerTextStyle: TextStyle(
        color: themeProvider.isDark() ? Colors.white : Colors.black,
      ),
      viewLeading: Icon(Icons.search,
          color: themeProvider.isDark() ? Colors.white : Colors.black),
      viewTrailing: [
        IconButton(
          icon: Icon(Icons.close,
              color: themeProvider.isDark() ? Colors.white : Colors.black),
          onPressed: () {
            searchControllerr.closeView('');
          },
        ),
      ],
      builder: (BuildContext context, searchControllerr) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            if (searchControllerr.isOpen) {
              searchControllerr.closeView('');
            } else {
              searchControllerr.openView();
            }
          },
        );
      },
      suggestionsBuilder: (BuildContext context, searchControllerr) {
        print("Search Query: ${searchControllerr.text}");

        return [
          const SizedBox(
            height: 15,
          ),
          FutureBuilder<NewsResponse?>(
            future: newsRepositoryContract.getNewsbysourceId(
              widget.sourceList[widget.sourceNumber].id!,
              languageProvider.appLanguage,
              1,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blackColor,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text(languageProvider.appLanguage == 'en'
                          ? 'An error occurred'
                          : 'حدث خطأ ما'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(languageProvider.appLanguage == 'en'
                            ? 'Try Again'
                            : 'حاول مرة أخرى'),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.status != 'ok') {
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.message!),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(languageProvider.appLanguage == 'en'
                            ? 'Try Again'
                            : 'حاول مرة أخرى'),
                      ),
                    ],
                  ),
                );
              }
              var newsList = snapshot.data!.articles!;
              final filteredNews = newsList.where((news) {
                final query = searchControllerr.text.toLowerCase();
                return news.title?.toLowerCase().contains(query) == true ||
                    news.description?.toLowerCase().contains(query) == true;
              }).toList();

              print("Filtered News Count: ${filteredNews.length}");

              if (filteredNews.isEmpty) {
                return Center(
                  child: Text(languageProvider.appLanguage == 'en'
                      ? 'No results found'
                      : 'لا توجد نتائج مطابقة'),
                );
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: ListView.builder(
                  itemCount: filteredNews.length,
                  itemBuilder: (context, index) {
                    return NewsItem(news: filteredNews[index]);
                  },
                ),
              );
            },
          ),
        ];
      },
    );
  }
}
