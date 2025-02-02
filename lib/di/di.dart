import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository_impl.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource_impl.dart';
import 'package:news_app/repository/sources/repository/source_repository_contract.dart';
import 'package:news_app/repository/sources/repository/source_repository_impl.dart';

SourceRepository injectRepositorySourceResponse(){
   return  SourceRepositoryImpl(sourceRemoteDataSource: injectRepositorySourceRemoteDataSource());
}
SourceRemoteDataSource injectRepositorySourceRemoteDataSource(){
   return SourceRemoteDatasourceImpl(apiManager: injectApiManager());
}
ApiManager injectApiManager(){
  return ApiManager();
}
NewsRepositoryContract injectRepositoryNewsResponse(){
   return NewsRepositoryImpl(remoteNewsRepository: injectNewsRemoteDataSource());
}
RemoteNewsRepository injectNewsRemoteDataSource(){
    return RemoteNewsRepositoryImpl(apiManager: injectApiManager());
 }