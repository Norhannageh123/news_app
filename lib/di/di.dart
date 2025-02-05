import 'package:news_app/ApI/api_manager.dart';
import 'package:news_app/repository/news/data_sources/offline_news_data_source.dart';
import 'package:news_app/repository/news/data_sources/offline_news_data_source_imol.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository.dart';
import 'package:news_app/repository/news/data_sources/remote_news_repository_impl.dart';
import 'package:news_app/repository/news/repository/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/repository/sources/data_sources/oflline_source_data_source.dart';
import 'package:news_app/repository/sources/data_sources/oflline_source_dta_source_impl.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource_impl.dart';
import 'package:news_app/repository/sources/repository/source_repository_contract.dart';
import 'package:news_app/repository/sources/repository/source_repository_impl.dart';

SourceRepository injectRepositorySourceResponse() {
  return SourceRepositoryImpl(
    sourceRemoteDataSource: injectRepositorySourceRemoteDataSource(),
    offlineDataSource: injectOfflineDataSource(),
  );
}

SourceRemoteDataSource injectRepositorySourceRemoteDataSource() {
  return SourceRemoteDatasourceImpl(apiManager: ApiManager.getInstance());
}

OfflineSourceDataSource injectOfflineDataSource() {
  return OfllineSourceDtaSourceImpl();
}


NewsRepositoryContract injectRepositoryNewsResponse() {
  return NewsRepositoryImpl(remoteNewsRepository: injectNewsRemoteDataSource(), offlineNewsDataSource:injectOfflineNewsDataSource());
}
OfflineNewsDataSource injectOfflineNewsDataSource(){
  return OfflineNewsDataSourceImpl();
}

RemoteNewsRepository injectNewsRemoteDataSource() {
  return RemoteNewsRepositoryImpl(apiManager: ApiManager.getInstance());
}
