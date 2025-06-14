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
import 'core/di/supabase_module.dart' as _i148;
import 'core/services/perplexity/perplexity_api_service.dart' as _i450;
import 'core/services/perplexity/perplexity_dio_config.dart' as _i454;
import 'features/auth/data/datasources/auth_remote_datasource.dart' as _i588;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/sign_in_usecase.dart' as _i151;
import 'features/auth/domain/usecases/sign_in_with_apple_usecase.dart' as _i302;
import 'features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i371;
import 'features/auth/domain/usecases/sign_out_usecase.dart' as _i31;
import 'features/auth/domain/usecases/sign_up_usecase.dart' as _i261;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/briefing/data/datasources/briefing_remote_datasource.dart'
    as _i1066;
import 'features/briefing/data/repositories/briefing_repository_impl.dart'
    as _i126;
import 'features/briefing/domain/repositories/briefing_repository.dart' as _i80;
import 'features/briefing/domain/usecases/get_todays_briefing.dart' as _i390;
import 'features/briefing/presentation/bloc/morning_briefing_bloc.dart'
    as _i921;

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
    final supabaseModule = _$SupabaseModule();
    final perplexityDioConfig = _$PerplexityDioConfig();
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabaseClient);
    gh.lazySingleton<_i828.AppConfig>(() => _i828.AppConfig());
    gh.lazySingleton<_i361.Dio>(
      () => perplexityDioConfig.perplexityDio,
      instanceName: 'perplexityDio',
    );
    gh.lazySingleton<_i1066.BriefingRemoteDataSource>(
        () => _i1066.BriefingRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i450.PerplexityApiService>(() =>
        _i450.PerplexityApiService(
            gh<_i361.Dio>(instanceName: 'perplexityDio')));
    gh.lazySingleton<_i588.AuthRemoteDataSource>(
        () => _i588.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i80.BriefingRepository>(() =>
        _i126.BriefingRepositoryImpl(gh<_i1066.BriefingRemoteDataSource>()));
    gh.lazySingleton<_i1015.AuthRepository>(
        () => _i111.AuthRepositoryImpl(gh<_i588.AuthRemoteDataSource>()));
    gh.lazySingleton<_i302.SignInWithAppleUseCase>(
        () => _i302.SignInWithAppleUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i371.SignInWithGoogleUseCase>(
        () => _i371.SignInWithGoogleUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i151.SignInUseCase>(
        () => _i151.SignInUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i261.SignUpUseCase>(
        () => _i261.SignUpUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i31.SignOutUseCase>(
        () => _i31.SignOutUseCase(gh<_i1015.AuthRepository>()));
    gh.lazySingleton<_i390.GetTodaysBriefing>(
        () => _i390.GetTodaysBriefing(gh<_i80.BriefingRepository>()));
    gh.factory<_i363.AuthBloc>(() => _i363.AuthBloc(
          signInUseCase: gh<_i151.SignInUseCase>(),
          signUpUseCase: gh<_i261.SignUpUseCase>(),
          signOutUseCase: gh<_i31.SignOutUseCase>(),
          signInWithGoogleUseCase: gh<_i371.SignInWithGoogleUseCase>(),
          signInWithAppleUseCase: gh<_i302.SignInWithAppleUseCase>(),
          authRepository: gh<_i1015.AuthRepository>(),
        ));
    gh.factory<_i921.MorningBriefingBloc>(
        () => _i921.MorningBriefingBloc(gh<_i390.GetTodaysBriefing>()));
    return this;
  }
}

class _$SupabaseModule extends _i148.SupabaseModule {}

class _$PerplexityDioConfig extends _i454.PerplexityDioConfig {}
