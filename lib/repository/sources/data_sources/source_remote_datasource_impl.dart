import 'package:injectable/injectable.dart';
import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource.dart';
@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDatasourceImpl implements SourceRemoteDataSource{
   ApiManager apiManager;
   SourceRemoteDatasourceImpl({required this.apiManager});
  @override
  Future<SourceResponse?> getSources(String categoryId,String currentLanguage)async {
   var  response= await apiManager.getSources(categoryId, currentLanguage);
   return response;
  }
}