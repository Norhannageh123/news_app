import 'package:news_app/Models/sourseResponce.dart';

abstract class SourceRemoteDataSource{
  Future<SourseResponce?>getSources(String categoryId,String currentLanguage);
}

abstract class SourceOfflineDataSource{

}