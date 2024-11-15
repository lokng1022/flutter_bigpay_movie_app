// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository.dart'
    as _i918;
import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository_impl.dart'
    as _i430;
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart'
    as _i259;
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository_impl.dart'
    as _i152;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.singleton<_i259.PopularMoviesRepository>(
        () => _i152.PopularMoviesRepositoryImpl());
    gh.singleton<_i918.EnvironmentRepository>(
        () => _i430.EnvironmentRepositoryImpl());
    return this;
  }
}
