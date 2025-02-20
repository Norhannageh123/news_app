import 'package:news_app/Models/NewsResponse.dart';

abstract class RemoteNewsRepository {
   Future<NewsResponse?> getNewsBySourceId(sourceId, currentLanguage, page);
}