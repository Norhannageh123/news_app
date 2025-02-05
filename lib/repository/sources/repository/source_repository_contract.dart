//todo:interface
import 'package:news_app/Models/sourseResponce.dart';

abstract class  SourceRepository{
  Future<SourceResponse?>getSources(String categoryId,String currentLanguage);
}