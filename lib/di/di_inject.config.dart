// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../ApI/api_manager.dart' as _i647;
import '../repository/sources/data_sources/oflline_source_data_source.dart'
    as _i462;
import '../repository/sources/data_sources/oflline_source_dta_source_impl.dart'
    as _i428;
import '../repository/sources/data_sources/source_remote_datasource.dart'
    as _i455;
import '../repository/sources/data_sources/source_remote_datasource_impl.dart'
    as _i763;
import '../repository/sources/repository/source_repository_contract.dart'
    as _i949;
import '../repository/sources/repository/source_repository_impl.dart' as _i892;
import '../Ui/home/Catergory%20Details/cubit/sourceViewModl.dart' as _i254;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i647.ApiManager>(() => _i647.ApiManager.getInstance());
    gh.factory<_i462.OfflineSourceDataSource>(
        () => _i428.OfllineSourceDtaSourceImpl());
    gh.factory<_i455.SourceRemoteDataSource>(() =>
        _i763.SourceRemoteDatasourceImpl(apiManager: gh<_i647.ApiManager>()));
    gh.factory<_i949.SourceRepository>(() => _i892.SourceRepositoryImpl(
          sourceRemoteDataSource: gh<_i455.SourceRemoteDataSource>(),
          offlineDataSource: gh<_i462.OfflineSourceDataSource>(),
        ));
    gh.factory<_i254.SourceViewModel>(() =>
        _i254.SourceViewModel(sourceRepository: gh<_i949.SourceRepository>()));
    return this;
  }
}
