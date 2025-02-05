import 'package:news_app/Models/NewsResponse.dart';

abstract class NewsRepositoryContract {
 Future<NewsResponse?> getNewsBySourceId(sourceId, currentLanguage, page);
}