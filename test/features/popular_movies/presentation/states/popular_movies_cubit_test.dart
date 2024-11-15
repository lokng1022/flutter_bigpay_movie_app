import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/popular_movies.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/states/popular_movies_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../../di/generated_mocks.mocks.dart';
import '../../../../mocks/popular_movies_mocks.dart';

void main() async {
  final List<PopularMovies> moviesList = [mockMovies, mockMovies, mockMovies];

  await dotenv.load(fileName: '.env');

  provideDummy<Either<String, List<PopularMovies>>>(Right(moviesList));

  late EnvironmentRepository environmentRepository;
  late PopularMoviesRepository popularMoviesRepository;

  setUp(() {
    environmentRepository = MockEnvironmentRepository();
    popularMoviesRepository = MockPopularMoviesRepository();

    GetIt.instance
        .registerSingleton<EnvironmentRepository>(environmentRepository);
    GetIt.instance
        .registerSingleton<PopularMoviesRepository>(popularMoviesRepository);

    when(popularMoviesRepository.fetchMoviesList())
        .thenAnswer((_) async => Right(moviesList));

    when(environmentRepository.getAccessToken())
        .thenAnswer((_) => dotenv.env['ACCESS_TOKEN_AUTH']);
    when(environmentRepository.getAPIToken())
        .thenAnswer((_) => dotenv.env['API_KEY_AUTH']);
  });

  tearDown(() {
    GetIt.instance.unregister(instance: environmentRepository);
    GetIt.instance.unregister(instance: popularMoviesRepository);
  });

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should fetch the list of movie list when cubit is initialised.',
    build: () => PopularMoviesCubit(),
    expect: () => [PopularMoviesLoadedState(popularMovies: moviesList)],
    verify: (_) {
      verify(popularMoviesRepository.fetchMoviesList()).called(1);
    },
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should fetch the list of movie list when cubit is initialised.',
    setUp: () {
      when(popularMoviesRepository.fetchMoviesList())
          .thenAnswer((_) async => const Left('Error while fetching data...'));
    },
    build: () => PopularMoviesCubit(),
    expect: () => [
      const PopularMoviesErrorState(
          errorMessage: 'Error while fetching data...')
    ],
    verify: (_) {
      verify(popularMoviesRepository.fetchMoviesList()).called(1);
    },
  );
}
