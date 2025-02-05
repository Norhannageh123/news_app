import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/Models/sourseResponce.dart';
import 'package:news_app/repository/sources/data_sources/oflline_source_data_source.dart';
import 'package:news_app/repository/sources/data_sources/source_remote_datasource.dart';
import 'package:news_app/repository/sources/repository/source_repository_contract.dart';
@Injectable(as:SourceRepository)
class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;
  OfflineSourceDataSource offlineDataSource;
  SourceRepositoryImpl(
      {required this.sourceRemoteDataSource, required this.offlineDataSource});
  @override
  Future<SourceResponse?> getSources(
      String categoryId, String currentLanguage) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        (connectivityResult.contains(ConnectivityResult.mobile))) {
      var sourceResponse =
          await sourceRemoteDataSource.getSources(categoryId, currentLanguage);
      offlineDataSource.saveSources(sourceResponse,categoryId);
      return sourceResponse;
    } else {
      var sourceResponse =
          await offlineDataSource.getSources(categoryId, currentLanguage);
      return sourceResponse;
    }
  }
}
