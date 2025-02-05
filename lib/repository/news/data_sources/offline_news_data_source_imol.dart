import 'package:hive/hive.dart';
import 'package:news_app/Models/NewsResponse.dart';
import 'package:news_app/repository/news/data_sources/offline_news_data_source.dart';

class OfflineNewsDataSourceImpl  implements OfflineNewsDataSource{
  @override
  Future<NewsResponse?> getNewsBySourceId(sourceId, currentLanguage, page)async {
    // TODO: read data
     var box= await Hive.openBox("news ");
     var news= NewsResponse.fromJson(box.get(sourceId));
    return news;
   // throw UnimplementedError();
  }

  @override
  void saveNews(NewsResponse newsResponse, String sourceId) async{
    // TODO: write data
    var box= await Hive.openBox("news ");
    await box.put(sourceId, newsResponse.toJson());
    await box.close();


  }

}