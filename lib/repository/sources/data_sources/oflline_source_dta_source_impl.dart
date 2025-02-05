import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/repository/sources/data_sources/oflline_source_data_source.dart';
@Injectable(as:  OfflineSourceDataSource)
class OfllineSourceDtaSourceImpl implements OfflineSourceDataSource{
  @override
  Future<SourceResponse?> getSources(String categoryId, String currentLanguage)async {
    // TODO: read data
    var box=await Hive.openBox("Source Tab");
     var sourceTab= box.get(categoryId);
     return sourceTab;
    //throw UnimplementedError();
  }

  @override
  void saveSources(SourceResponse? sourceResponse,String categoryId)async {
    // TODO: wrire data
    var box= await Hive.openBox("Source Tab");
    await box.put(categoryId, sourceResponse);
    await box.close();

  }

}