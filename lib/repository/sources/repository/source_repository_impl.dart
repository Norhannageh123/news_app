import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource.dart';
import 'package:news_app/repository/sources/repository/source_repository_contract.dart';

class SourceRepositoryImpl implements SourceRepository {
   SourceRemoteDataSource sourceRemoteDataSource;
   SourceRepositoryImpl({required this.sourceRemoteDataSource});
  @override
  Future<SourseResponce?> getSources(String categoryId,String currentLanguage) {
      return sourceRemoteDataSource.getSources(categoryId, currentLanguage);
  }
}