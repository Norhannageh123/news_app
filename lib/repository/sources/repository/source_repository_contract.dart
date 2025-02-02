//todo:interface
import 'package:news_app/Models/sourseResponce.dart';

abstract class  SourceRepository{
  Future<SourseResponce?>getSources(String categoryId,String currentLanguage);
}