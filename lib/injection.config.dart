// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import 'core/config/app_config.dart' as _i828;
import 'core/services/perplexity/perplexity_api_service.dart' as _i450;
import 'core/services/perplexity/perplexity_dio_config.dart' as _i454;
import 'features/auth/data/datasources/auth_remote_datasource.dart' as _i588;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/sign_in_usecase.dart' as _i151;
import 'features/auth/domain/usecases/sign_out_usecase.dart' as _i31;
import 'features/auth/domain/usecases/sign_up_usecase.dart' as _i261;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/briefing/data/repositories/issue_repository_impl.dart'
    as _i634;
import 'features/briefing/domain/repositories/issue_repository.dart' as _i527;
import 'features/prediction/data/repositories/prediction_repository_impl.dart'
    as _i754;
import 'features/prediction/domain/repositories/prediction_repository.dart'
    as _i656;

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
    final perplexityDioConfig = _$PerplexityDioConfig();
    gh.lazySingleton<_i828.AppConfig>(() => _i828.AppConfig());
    gh.lazySingleton<_i361.Dio>(
      () => perplexityDioConfig.perplexityDio,
      instanceName: 'perplexityDio',
    );
    gh.lazySingleton<_i450.PerplexityApiService>(() =>
        _i450.PerplexityApiService(
            gh<_i361.Dio>(instanceName: 'perplexityDio')));
    gh.lazySingleton<_i527.IssueRepository>(
        () => _i634.IssueRepositoryImpl(gh<_i450.PerplexityApiService>()));
    gh.lazySingleton<_i588.AuthRemoteDataSource>(
        () => _i588.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i656.PredictionRepository>(
        () => _i754.PredictionRepositoryImpl(gh<_i450.PerplexityApiService>()));
    gh.lazySingleton<_i1015.AuthRepository>(
        () => _i111.AuthRepositoryImpl(gh<_i588.AuthRemoteDataSource>()));
    gh.lazySingleton<_i151.SignInUseCase>(
        () => _i151.SignInUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i261.SignUpUseCase>(
        () => _i261.SignUpUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i31.SignOutUseCase>(
        () => _i31.SignOutUseCase(gh<_i1015.AuthRepository>()));
    gh.factory<_i363.AuthBloc>(() => _i363.AuthBloc(
          signInUseCase: gh<_i151.SignInUseCase>(),
          signUpUseCase: gh<_i261.SignUpUseCase>(),
          signOutUseCase: gh<_i31.SignOutUseCase>(),
          authRepository: gh<_i1015.AuthRepository>(),
        ));
    return this;
  }
}

class _$PerplexityDioConfig extends _i454.PerplexityDioConfig {}
