import 'package:news_app/Models/sourseResponce.dart';

abstract class OfflineSourceDataSource{
 Future<SourceResponse?> getSources (String categoryId,String currentLanguage);
 void saveSources(SourceResponse?  sourceResponse,String categoryId);
}