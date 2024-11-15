import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository.dart';
import 'package:flutter_bigpay_movie_app/core/utils/constant/app_constant.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/popular_movies.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Singleton(as: PopularMoviesRepository)
class PopularMoviesRepositoryImpl implements PopularMoviesRepository {
  late bool shouldFetch;

  @override
  Future<Either<String, List<PopularMovies>>> fetchMoviesList(
      {int page = 1}) async {
    const String baseApiUrl = popularMoviesBaseUrl;
    const String baseApiUrlPath = popularMoviesBaseUrlPath;

    final String? accessToken =
        GetIt.instance<EnvironmentRepository>().getAccessToken();

    final Map<String, String> queryParameters = {'page': page.toString()};

    final Uri uri = Uri.https(baseApiUrl, baseApiUrlPath, queryParameters);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<PopularMovies> moviesList = (responseData['results'] as List)
            .map((movie) => PopularMovies.fromMap(movie))
            .toList();

        return Right(moviesList);
      } else {
        return Left(
            'Please try again later... (Status code ${response.statusCode})');
      }
    } on SocketException catch (_) {
      return const Left('Please try to reconnect...');
    } on http.ClientException catch (_) {
      return const Left('Please try again...');
    }
  }

  @override
  String getMoviePosterUrl({required String moviePosterPath}) =>
      moviePosterPrefixUrl + moviePosterPath;

  @override
  bool getBoolValueForFetchMovies() => shouldFetch;

  @override
  void setBoolValueForFetchMovies({bool shouldFetchMore = false}) {
    shouldFetch = shouldFetchMore;
  }
}
