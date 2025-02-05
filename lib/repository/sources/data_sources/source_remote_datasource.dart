import 'package:news_app/Models/sourseResponce.dart';

abstract class SourceRemoteDataSource{
  Future<SourceResponse?>getSources(String categoryId,String currentLanguage);
}

