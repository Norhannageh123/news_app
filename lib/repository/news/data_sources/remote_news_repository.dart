import 'package:news_app/Models/NewsResponse.dart';

abstract class RemoteNewsRepository {
   Future<NewsResponse?> getNewsbysourceId(sourceId, currentLanguage, page);
}