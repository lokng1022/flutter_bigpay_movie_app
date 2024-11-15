part of 'popular_movies_cubit.dart';

/// States of [PopularMoviesCubit].
abstract class PopularMoviesState extends Equatable {
  /// Constructor for [PopularMoviesState].
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

/// Initial state.
final class PopularMoviesInitialState extends PopularMoviesState {}

/// Loading state.
final class PopularMoviesLoadingState extends PopularMoviesState {}

/// Loaded state when the movie list is fetched.
final class PopularMoviesLoadedState extends PopularMoviesState {
  /// Constructor for [PopularMoviesLoadedState].
  const PopularMoviesLoadedState({
    required this.popularMovies,
  });

  /// Movies list.
  final List<PopularMovies> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

/// Error state when there's an error while fetching data.
final class PopularMoviesErrorState extends PopularMoviesState {
  /// Constructor for [PopularMoviesErrorState].
  const PopularMoviesErrorState({required this.errorMessage});

  /// Error message.
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
