import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/repository/news/data_sources/offline_news_data_source.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  RemoteNewsRepository remoteNewsRepository;
  OfflineNewsDataSource offlineNewsDataSource;
  NewsRepositoryImpl(
      {required this.remoteNewsRepository,
      required this.offlineNewsDataSource});
  @override
  Future<NewsResponse?> getNewsBySourceId(
      sourceId, currentLanguage, page) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        (connectivityResult.contains(ConnectivityResult.mobile))) {
      var newsResponse = await remoteNewsRepository.getNewsBySourceId(
          sourceId, currentLanguage, page);
      offlineNewsDataSource.saveNews(newsResponse!, sourceId);
      return newsResponse;
    } else {
      var newsResponse = offlineNewsDataSource.getNewsBySourceId(
          sourceId, currentLanguage, page);
      return newsResponse;
    }
  }
}
