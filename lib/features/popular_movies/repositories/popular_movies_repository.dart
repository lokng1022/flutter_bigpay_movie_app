import 'package:either_dart/either.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/popular_movies.dart';

/// Repository for handling [PopularMovies] list.
abstract class PopularMoviesRepository {
  /// Fetches movies list from api.
  Future<Either<String, List<PopularMovies>>> fetchMoviesList({int page = 1});

  /// Get movie poster url.
  String getMoviePosterUrl({required String moviePosterPath});

  /// Determines whether we should fetch more movies.
  bool getBoolValueForFetchMovies();

  /// Set value to determine whether we should fetch more.
  void setBoolValueForFetchMovies({bool shouldFetchMore});
}
