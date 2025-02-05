import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/news/Cubit/newsState.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';

class NewsViewModel extends Cubit<NewsState> {
 late NewsRepositoryContract newsRepositoryContract;
  NewsViewModel({required this.newsRepositoryContract}) : super(NewsLoadingState());
  List<dynamic> newsList = []; 
  int currentPage = 1;
  bool hasMore = true; 

  void getNews(String sourceId, String currentLanguage, int page) async {
    if (!hasMore) return; 

    try {
      if (page == 1) {
        emit(NewsLoadingState());
      }

      var response = await newsRepositoryContract.getNewsBySourceId(sourceId, currentLanguage, page);

      if (response?.status == "error") {
        emit(NewsErrorState(errorMessage: response!.message!));
        return;
      }

      if (response?.status == "ok") {
        if (response!.articles!.isNotEmpty) {
          newsList.addAll(response.articles!); 
          hasMore = response.articles!.length > 0;
          emit(NewsSuccessState(newsList: List.from(newsList), hasMore: hasMore));
        } else {
          hasMore = false; 
        }
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
