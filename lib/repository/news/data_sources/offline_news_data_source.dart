import 'package:news_app/Models/NewsResponse.dart';

abstract class OfflineNewsDataSource  {
   Future<NewsResponse?> getNewsBySourceId(sourceId, currentLanguage, page);
   void saveNews(NewsResponse newsResponse,String sourceId);
}