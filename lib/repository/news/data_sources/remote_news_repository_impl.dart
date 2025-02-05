import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository.dart';

class RemoteNewsRepositoryImpl implements RemoteNewsRepository{
  ApiManager apiManager;
  RemoteNewsRepositoryImpl({required this.apiManager});
  @override
  Future<NewsResponse?> getNewsBySourceId(sourceId, currentLanguage, page)async {
    var response= await apiManager.getNewsBySourceId(sourceId, currentLanguage, page);
    return response;
  }

}