import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/models.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'popular_movies_state.dart';

/// [PopularMoviesCubit] manages the list of popular movies.
class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  /// Constructor for [PopularMoviesCubit]
  PopularMoviesCubit() : super(PopularMoviesInitialState()) {
    fetchPopularMovies(1);
  }

  /// Fetch popular movies list.
  Future<void> fetchPopularMovies(int page) async {
    emit(PopularMoviesLoadingState());

    final List<PopularMovies> moviesList = <PopularMovies>[];

    final Either<String, List<PopularMovies>> response =
        await GetIt.instance<PopularMoviesRepository>()
            .fetchMoviesList(page: page);

    response.fold((String left) {
      emit(PopularMoviesErrorState(errorMessage: left));
    }, (List<PopularMovies> right) {
      moviesList.addAll(right);

      emit(PopularMoviesLoadedState(popularMovies: right));
    });
  }
}
