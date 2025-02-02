import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract{
        RemoteNewsRepository  remoteNewsRepository;
  NewsRepositoryImpl({required this.remoteNewsRepository});
  @override
  Future<NewsResponse?> getNewsbysourceId(sourceId, currentLanguage, page) {
    return remoteNewsRepository.getNewsbysourceId(sourceId, currentLanguage, page);
  }
}